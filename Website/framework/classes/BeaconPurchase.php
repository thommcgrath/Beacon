<?php

class BeaconPurchase {
	protected string $purchaseId;
	protected string $merchantReference;
	protected array $lines = [];
	protected string $email;
	protected int $dateCreated;
	protected ?int $dateFulfilled = null;
	protected ?string $clientReferenceId = null;
	protected string $taxLocality;
	protected ?string $notes = null;
	protected float $conversionRate;
	protected string $currencyCode;
	protected float $currencyMultiplier;
	protected int $subtotal = 0;
	protected int $discounts = 0;
	protected int $taxes = 0;
	protected int $total = 0;
	protected int $amountPaid = 0;
	protected ?array $metadata = null;

	public function __construct(string $merchantReference, string $email, int $dateCreated, string $taxLocality, string $currencyCode, float $conversionRate, float $currencyMultiplier) {
		$this->purchaseId = BeaconUUID::v5($merchantReference);
		$this->merchantReference = $merchantReference;
		$this->email = $email;
		$this->dateCreated = $dateCreated;
		$this->taxLocality = $taxLocality;
		$this->currencyCode = $currencyCode;
		$this->conversionRate = $conversionRate;
		$this->currencyMultiplier = $currencyMultiplier;
	}

	public function AddNewLine(string $productId, int $unitPrice, int $quantity, int $discounts, int $taxes) {
		$this->AddLine(new BeaconLineItem($productId, $unitPrice, $quantity, $discounts, $taxes, $this->currencyCode, $this->currencyMultiplier, $this->conversionRate));
	}

	public function AddLine(BeaconLineItem $item, bool $updatePrices = true): void {
		$this->lines[] = $item;
		if ($updatePrices) {
			$this->discounts += $item->Discounts();
			$this->taxes += $item->Taxes();
			$this->subtotal += ($item->UnitPrice() * $item->Quantity());
			$this->total = ($this->subtotal + $this->taxes) - $this->discounts;
		}
	}

	public function PurchaseId(): string {
		return $this->purchaseId;
	}

	public function SetAmountPaid(int $amountPaid): void {
		$this->amountPaid = $amountPaid;
	}

	public function SetNotes(string $notes): void {
		$this->notes = $notes;
	}

	public function SetClientReferenceId(string $clientReferenceId): void {
		$this->clientReferenceId = $clientReferenceId;
	}

	public function SetDateFulfilled(int $dateFulfilled): void {
		$this->dateFulfilled = $dateFulfilled;
	}

	public function SetSubtotal(int $subtotal): void {
		$this->subtotal = $subtotal;
	}

	public function SetDiscounts(int $discounts): void {
		$this->discounts = $discounts;
	}

	public function SetTaxes(int $taxes): void {
		$this->taxes = $taxes;
	}

	public function SetTotal(int $total): void {
		$this->total = $total;
	}

	public function SetMetadata(?array $metadata): void {
		$this->metadata = $metadata;
	}

	public function SetCurrencyCode(string $currencyCode, ?float $currencyMultiplier = null): void {
		if (is_null($currencyMultiplier)) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT stripe_multiplier FROM public.currencies WHERE code = $1;', $currencyCode);
			$currencyMultiplier = $rows->Field('stripe_multiplier');
		}
		$this->currencyCode = $currencyCode;
		$this->currencyMultiplier = $currencyMultiplier;

		foreach ($this->lines as $line) {
			$line->SetCurrencyCode($currencyCode, $currencyMultiplier);
		}
	}

	public function SetConversionRate(float $conversionRate): void {
		$this->conversionRate = $conversionRate;
		foreach ($this->lines as $line) {
			$line->SetConversionRate($conversionRate);
		}
	}

	public function SaveTo(BeaconDatabase $database): void {
		$subtotal = static::HumanPrice($this->subtotal, $this->currencyMultiplier, 1.0);
		$discounts = static::HumanPrice($this->discounts, $this->currencyMultiplier, 1.0);
		$taxes = static::HumanPrice($this->taxes, $this->currencyMultiplier, 1.0);
		$total = static::HumanPrice($this->total, $this->currencyMultiplier, 1.0);
		$amountPaid = static::HumanPrice($this->amountPaid, $this->currencyMultiplier, $this->conversionRate);
		$subtotalUsd = static::HumanPrice($this->subtotal, $this->currencyMultiplier, $this->conversionRate);
		$discountsUsd = static::HumanPrice($this->discounts, $this->currencyMultiplier, $this->conversionRate);
		$taxesUsd = static::HumanPrice($this->taxes, $this->currencyMultiplier, $this->conversionRate);
		$totalUsd = static::HumanPrice($this->total, $this->currencyMultiplier, $this->conversionRate);
		$amountPaidUsd = static::HumanPrice($this->amountPaid, $this->currencyMultiplier, $this->conversionRate);
		$metadata = is_null($this->metadata) ? null : json_encode((object) $this->metadata);

		$emailSql = 'uuid_for_email($2::email, TRUE)';
		if (BeaconUUID::Validate($this->email)) {
			$emailSql = '$2';
		}

		$database->Query("INSERT INTO public.purchases (purchase_id, purchaser_email, merchant_reference, client_reference_id, notes, tax_locality, currency, conversion_rate, purchase_date, date_fulfilled, subtotal, discount, tax, total, amount_paid, subtotal_usd, discount_usd, tax_usd, total_usd, amount_paid_usd, metadata) VALUES ($1, {$emailSql}, $3, $4, $5, $6, $7, $8, TO_TIMESTAMP($9), TO_TIMESTAMP($10), $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21);", $this->purchaseId, $this->email, $this->merchantReference, $this->clientReferenceId, $this->notes, $this->taxLocality, $this->currencyCode, $this->conversionRate, $this->dateCreated, $this->dateFulfilled, $subtotal, $discounts, $taxes, $total, $amountPaid, $subtotalUsd, $discountsUsd, $taxesUsd, $totalUsd, $amountPaidUsd, $metadata);

		foreach ($this->lines as $line) {
			$line->SaveTo($database, $this->purchaseId);
		}
	}

	protected static function HumanPrice(int $machinePrice, float $currencyMultiplier, float $conversionRate): float {
		return round(($machinePrice / $currencyMultiplier) * $conversionRate, 2);
	}

	public function LineCount(): int {
		return count($this->lines);
	}

	public static function Load(BeaconDatabase $database, string $purchaseId): ?BeaconPurchase {
		$rows = $database->Query('SELECT purchases.purchase_id, purchases.merchant_reference, purchases.purchaser_email, EXTRACT(EPOCH FROM purchases.purchase_date) AS purchase_date, EXTRACT(EPOCH FROM purchases.date_fulfilled) AS date_fulfilled, purchases.client_reference_id, purchases.tax_locality, purchases.notes, purchases.conversion_rate, purchases.currency, currencies.stripe_multiplier, purchases.subtotal, purchases.discount, purchases.tax, purchases.total, purchases.amount_paid, purchases.metadata FROM public.purchases INNER JOIN public.currencies ON (purchases.currency = currencies.code) WHERE (purchase_id::TEXT = $1 OR merchant_reference = $1);', $purchaseId);
		if ($rows->RecordCount() !== 1) {
			return null;
		}

		$currencyMultiplier = $rows->Field('stripe_multiplier');
		$purchase = new static($rows->Field('merchant_reference'), $rows->Field('purchaser_email'), $rows->Field('purchase_date'), $rows->Field('tax_locality'), $rows->Field('currency'), $rows->Field('conversion_rate'), $currencyMultiplier);
		$purchase->purchaseId = $rows->Field('purchase_id'); // For legacy support
		$purchase->dateFulfilled = $rows->Field('date_fulfilled');
		$purchase->notes = $rows->Field('notes');
		$purchase->subtotal = $rows->Field('subtotal') * $currencyMultiplier;
		$purchase->discounts = $rows->Field('discount') * $currencyMultiplier;
		$purchase->taxes = $rows->Field('tax') * $currencyMultiplier;
		$purchase->total = $rows->Field('total') * $currencyMultiplier;
		$purchase->amountPaid = $rows->Field('amount_paid') * $currencyMultiplier;
		$purchase->metadata = is_null($rows->Field('metadata')) ? null : json_decode($rows->Field('metadata'), true);
		$purchase->lines = BeaconLineItem::Load($database, $purchase->purchaseId);
		return $purchase;
	}

	public function Update(BeaconDatabase $database): void {
		$amountPaid = static::HumanPrice($this->amountPaid, $this->currencyMultiplier, $this->conversionRate);
		$subtotalUsd = static::HumanPrice($this->subtotal, $this->currencyMultiplier, $this->conversionRate);
		$discountsUsd = static::HumanPrice($this->discounts, $this->currencyMultiplier, $this->conversionRate);
		$taxesUsd = static::HumanPrice($this->taxes, $this->currencyMultiplier, $this->conversionRate);
		$totalUsd = static::HumanPrice($this->total, $this->currencyMultiplier, $this->conversionRate);
		$amountPaidUsd = static::HumanPrice($this->amountPaid, $this->currencyMultiplier, $this->conversionRate);
		$metadata = is_null($this->metadata) ? null : json_encode((object) $this->metadata);

		$database->Query('UPDATE public.purchases SET amount_paid = $2, amount_paid_usd = $3, notes = $4, client_reference_id = $5, date_fulfilled = TO_TIMESTAMP($6), metadata = $7, currency = $8, conversion_rate = $9, subtotal_usd = $10, discount_usd = $11, tax_usd = $12, total_usd = $13 WHERE purchase_id = $1 AND (amount_paid != $2 OR amount_paid_usd != $3 OR notes != $4 OR client_reference_id != $5 OR date_fulfilled IS DISTINCT FROM TO_TIMESTAMP($6) OR metadata IS DISTINCT FROM $7 OR currency != $8 OR conversion_rate != $9 OR subtotal_usd != $10 OR discount_usd != $11 OR tax_usd != $12 OR total_usd != $13);', $this->purchaseId, $amountPaid, $amountPaidUsd, $this->notes, $this->clientReferenceId, $this->dateFulfilled, $metadata, $this->currencyCode, $this->conversionRate, $subtotalUsd, $discountsUsd, $taxesUsd, $totalUsd);
		foreach ($this->lines as $line) {
			$line->Update($database);
		}
	}
}

?>

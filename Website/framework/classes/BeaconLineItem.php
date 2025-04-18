<?php

class BeaconLineItem {
	protected string $lineId;
	protected string $productId;
	protected int $unitPrice;
	protected int $quantity;
	protected int $discounts;
	protected int $taxes;
	protected float $conversionRate;
	protected string $currencyCode;
	protected float $currencyMultiplier;
	protected bool $isNew = true;

	public function __construct(string $productId, int $unitPrice, int $quantity, int $discounts, int $taxes, string $currencyCode, float $conversionRate, float $currencyMultiplier) {
		$this->productId = $productId;
		$this->unitPrice = $unitPrice;
		$this->quantity = $quantity;
		$this->discounts = $discounts;
		$this->taxes = $taxes;
		$this->conversionRate = $conversionRate;
		$this->currencyCode = strtoupper($currencyCode);
		$this->currencyMultiplier = $currencyMultiplier;
	}

	public function SaveTo(BeaconDatabase $database, string $purchaseId): void {
		$unitPrice = static::HumanPrice($this->unitPrice, $this->currencyMultiplier, 1.0);
		$discounts = static::HumanPrice($this->discounts, $this->currencyMultiplier, 1.0);
		$taxes = static::HumanPrice($this->taxes, $this->currencyMultiplier, 1.0);
		$subtotal = static::HumanPrice($this->unitPrice * $this->quantity, $this->currencyMultiplier, 1.0);
		$lineTotal = static::HumanPrice((($this->unitPrice * $this->quantity) + $this->taxes) - $this->discounts, $this->currencyMultiplier, 1.0);

		$unitPriceUsd = static::HumanPrice($this->unitPrice, $this->currencyMultiplier, $this->conversionRate);
		$discountsUsd = static::HumanPrice($this->discounts, $this->currencyMultiplier, $this->conversionRate);
		$taxesUsd = static::HumanPrice($this->taxes, $this->currencyMultiplier, $this->conversionRate);
		$subtotalUsd = static::HumanPrice($this->unitPrice * $this->quantity, $this->currencyMultiplier, $this->conversionRate);
		$lineTotalUsd = static::HumanPrice((($this->unitPrice * $this->quantity) + $this->taxes) - $this->discounts, $this->currencyMultiplier, $this->conversionRate);

		if ($this->isNew) {
			$rows = $database->Query('INSERT INTO public.purchase_items (purchase_id, product_id, currency, quantity, unit_price, subtotal, discount, tax, line_total, conversion_rate, unit_price_usd, subtotal_usd, discount_usd, tax_usd, line_total_usd) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15) RETURNING line_id;', $purchaseId, $this->productId, $this->currencyCode, $this->quantity, $unitPrice, $subtotal, $discounts, $taxes, $lineTotal, $this->conversionRate, $unitPriceUsd, $subtotalUsd, $discountsUsd, $taxesUsd, $lineTotalUsd);
			$this->lineId = $rows->Field('line_id');
		} else {
			$database->Query('UPDATE public.purchase_items SET currency = $2, conversion_rate = $3, unit_price_usd = $4, subtotal_usd = $5, discount_usd = $6, tax_usd = $7, line_total_usd = $8 WHERE line_id = $1 AND (currency != $2 OR conversion_rate != $3 OR unit_price_usd != $4 OR subtotal_usd != $5 OR discount_usd != $6 OR tax_usd != $7 OR line_total_usd != $8);', $this->lineId, $this->currencyCode, $this->conversionRate, $unitPriceUsd, $subtotalUsd, $discountsUsd, $taxesUsd, $lineTotalUsd);
		}
	}

	public function UnitPrice(): int {
		return $this->unitPrice;
	}

	public function Quantity(): int {
		return $this->quantity;
	}

	public function Discounts(): int {
		return $this->discounts;
	}

	public function Taxes(): int {
		return $this->taxes;
	}

	public function SetCurrencyCode(string $currencyCode, ?float $currencyMultiplier = null): void {
		if (is_null($currencyMultiplier)) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT stripe_multiplier FROM public.currencies WHERE code = $1;', $currencyCode);
			$currencyMultiplier = $rows->Field('stripe_multiplier');
		}
		$this->currencyCode = $currencyCode;
		$this->currencyMultiplier = $currencyMultiplier;
	}

	public function SetConversionRate(float $conversionRate): void {
		$this->conversionRate = $conversionRate;
	}

	protected static function HumanPrice(int $machinePrice, float $currencyMultiplier, float $conversionRate): float {
		return round(($machinePrice / $currencyMultiplier) * $conversionRate, 2);
	}

	public static function Load(BeaconDatabase $database, string $purchaseId): array {
		$lines = [];
		$rows = $database->Query('SELECT purchase_items.line_id, purchase_items.product_id, purchase_items.currency, purchase_items.quantity, purchase_items.unit_price, purchase_items.subtotal, purchase_items.discount, purchase_items.tax, purchase_items.line_total, purchase_items.conversion_rate, currencies.stripe_multiplier FROM public.purchase_items INNER JOIN public.currencies ON (purchase_items.currency = currencies.code) WHERE purchase_id = $1;', $purchaseId);
		while (!$rows->EOF()) {
			$currencyMultiplier = $rows->Field('stripe_multiplier');
			$lineItem = new static($rows->Field('product_id'), $rows->Field('unit_price') * $currencyMultiplier, $rows->Field('quantity'), $rows->Field('discount') * $currencyMultiplier, $rows->Field('tax') * $currencyMultiplier, $rows->Field('currency'), $rows->Field('conversion_rate'), $currencyMultiplier);
			$lineItem->lineId = $rows->Field('line_id');
			$lineItem->isNew = false;
			$lines[] = $lineItem;
			$rows->MoveNext();
		}
		return $lines;
	}
}

?>

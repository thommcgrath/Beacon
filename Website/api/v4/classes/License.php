<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception, DateTime, JsonSerializable;

class License extends DatabaseObject implements JsonSerializable {
	protected string $licenseId;
	protected string $userId;
	protected string $purchaseId;
	protected string $productId;
	protected string $productName;
	protected int $productFlags;
	protected ?string $expiration;
	protected ?string $firstUsed;

	public function __construct(BeaconRecordSet $row) {
		$this->licenseId = $row->Field('license_id');
		$this->userId = $row->Field('user_id');
		$this->purchaseId = $row->Field('purchase_id');
		$this->productId = $row->Field('product_id');
		$this->productName = $row->Field('product_name');
		$this->productFlags = filter_var($row->Field('product_flags'), FILTER_VALIDATE_INT);
		$this->expiration = $row->Field('expiration');
		$this->firstUsed = $row->Field('first_used');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'licenses', [
			new DatabaseObjectProperty('licenseId', ['primaryKey' => true, 'columnName' => 'license_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'accessor' => 'users.user_id']),
			new DatabaseObjectProperty('purchaseId', ['columnName' => 'purchase_id']),
			new DatabaseObjectProperty('productId', ['columnName' => 'product_id']),
			new DatabaseObjectProperty('productName', ['columnName' => 'product_name', 'accessor' => 'products.product_name']),
			new DatabaseObjectProperty('productFlags', ['columnName' => 'product_flags', 'accessor' => 'products.flags']),
			new DatabaseObjectProperty('expiration', ['accessor' => "DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%)"]),
			new DatabaseObjectProperty('firstUsed', ['columnName' => 'first_used', 'accessor' => "DATE_TRUNC('second', purchases.first_used)"]),
		], [
			"INNER JOIN public.products ON (licenses.product_id = products.product_id)",
			"INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id)",
			"INNER JOIN public.users ON (purchases.purchaser_email = users.email_id)"
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'purchaseId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->orderBy = $schema->Accessor('expiration') . ' DESC';
	}

	public function LicenseId(): string {
		return $this->licenseId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function PurchaseId(): string {
		return $this->purchaseId;
	}

	public function ProductId(): string {
		return $this->productId;
	}

	public function ProductName(): string {
		return $this->productName;
	}

	public function ProductFlags(): int {
		return $this->productFlags;
	}

	public function Expiration(): ?string {
		return $this->expiration;
	}

	public function Expires(): bool {
		return is_null($this->expiration) === false;
	}

	public function FirstUsed(): ?string {
		return $this->firstUsed;
	}

	public function jsonSerialize(): mixed {
		$json = [
			'licenseId' => $this->licenseId,
			'productId' => $this->productId,
			'flags' => $this->productFlags,
			'firstUsed' => $this->firstUsed,
			'expires' => $this->expiration,
			'maxBuild' => $this->NewestLicensedBuild(),
		];
		return $json;
	}

	public function NewestLicensedBuild(): int {
		if (is_null($this->expiration)) {
			return 999999999;
		}

		$database = BeaconCommon::Database();

		// Find the newest. If there is a beta running, that changes the answer.
		$results = $database->Query('SELECT build_number, stage FROM public.updates WHERE published IS NOT NULL ORDER BY build_number DESC LIMIT 1;');
		$latestBuild = $results->Field('build_number');
		$latestBuildBase = floor($latestBuild / 1000);
		$isBetaActive = $results->Field('stage') < 3;

		// Find the latest build the expiration allows.
		$results = $database->Query('SELECT build_number FROM public.updates WHERE published <= $1 AND stage >= $2 ORDER BY build_number DESC LIMIT 1;', $this->expiration, ($isBetaActive ? 0: 3));
		$allowedBuild = $results->Field('build_number');
		$allowedBuildBase = floor($allowedBuild / 1000);

		if ($isBetaActive && $allowedBuildBase === $latestBuildBase) {
			// User had access to at least one of the active betas, so they should have access to all betas until release
			$allowedBuild = ($allowedBuildBase * 1000) + 299;
		} else {
			$allowedBuild = ($allowedBuildBase * 1000) + 999;
		}

		return $allowedBuild;
	}
}

?>

<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception, DateTime, JsonSerializable;

class License extends DatabaseObject implements JsonSerializable {
	protected $licenseId;
	protected $userId;
	protected $purchaseId;
	protected $productId;
	protected $productName;
	protected $productFlags;
	protected $expiration;
	
	public function __construct(BeaconRecordSet $row) {
		$this->licenseId = $row->Field('license_id');
		$this->userId = $row->Field('user_id');
		$this->purchaseId = $row->Field('purchase_id');
		$this->productId = $row->Field('product_id');
		$this->productName = $row->Field('product_name');
		$this->productFlags = filter_var($row->Field('product_flags'), FILTER_VALIDATE_INT);
		$this->expiration = $row->Field('expiration');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'licenses', [
			new DatabaseObjectProperty('licenseId', ['primaryKey' => true, 'columnName' => 'license_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'accessor' => 'users.user_id']),
			new DatabaseObjectProperty('purchaseId', ['columnName' => 'purchase_id']),
			new DatabaseObjectProperty('productId', ['columnName' => 'product_id']),
			new DatabaseObjectProperty('productName', ['columnName' => 'product_name', 'accessor' => 'products.product_name']),
			new DatabaseObjectProperty('productFlags', ['columnName' => 'product_flags', 'accessor' => 'products.flags']),
			new DatabaseObjectProperty('expiration', ['accessor' => "DATE_TRUNC('second', %%TABLE%%.%%COLUMN%%)"])
		], [
			"INNER JOIN public.products ON (licenses.product_id = products.product_id)",
			"INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id)",
			"INNER JOIN public.users ON (purchases.purchaser_email = users.email_id)"
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
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
	
	public function HashBits(int $version): string {
		// $version unused for now
		
		$bits = [
			strtolower($this->productId),
			$this->productFlags
		];
		if (is_null($this->expiration) === false) {
			$expiration = new DateTime($this->expiration);
			$bits[] = $expiration->format('Y-m-d H:i:sO');
		}
		return implode(':', $bits);
	}
	
	public function jsonSerialize(): mixed {
		$json = [
			'productId' => $this->productId,
			'flags' => $this->productFlags
		];
		if (is_null($this->expiration) === false) {
			$json['expires'] = $this->expiration;
		}
		return $json;
	}
}

?>

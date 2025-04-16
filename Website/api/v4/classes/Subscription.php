<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, Exception, DateTime, JsonSerializable;

class Subscription extends DatabaseObject implements JsonSerializable {
	protected string $subscriptionId;
	protected string $userId;
	protected string $emailId;
	protected string $productId;
	protected string $productName;
	protected string $productGameId;
	protected array $productMetadata;
	protected int $productFlags;
	protected int $created;
	protected int $expiration;
	protected string $lastPurchaseId;
	protected int $unitsUsed;
	protected int $unitsAllowed;

	public function __construct(BeaconRecordSet $row) {
		$this->subscriptionId = $row->Field('subscription_id');
		$this->userId = $row->Field('user_id');
		$this->emailId = $row->Field('email_id');
		$this->productId = $row->Field('product_id');
		$this->productName = $row->Field('product_name');
		$this->productGameId = $row->Field('game_id');
		$this->productMetadata = json_decode($row->Field('metadata'), true);
		$this->productFlags = filter_var($row->Field('flags'), FILTER_VALIDATE_INT);
		$this->created = $row->Field('date_created');
		$this->expiration = $row->Field('date_expires');
		$this->lastPurchaseId = $row->Field('purchase_id');
		$this->unitsUsed = $row->Field('units_used');
		$this->unitsAllowed = $row->Field('units_allowed');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'public',
			table: 'user_subscriptions',
			definitions: [
				new DatabaseObjectProperty('subscriptionId', ['primaryKey' => true, 'columnName' => 'subscription_id']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('emailId', ['columnName' => 'email_id']),
				new DatabaseObjectProperty('productId', ['columnName' => 'product_id']),
				new DatabaseObjectProperty('productName', ['columnName' => 'product_name']),
				new DatabaseObjectProperty('productGameId', ['columnName' => 'game_id']),
				new DatabaseObjectProperty('productMetadata', ['columnName' => 'metadata']),
				new DatabaseObjectProperty('productFlags', ['columnName' => 'flags']),
				new DatabaseObjectProperty('created', ['columnName' => 'date_created', 'accessor' => "EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)"]),
				new DatabaseObjectProperty('expiration', ['columnName' => 'date_expires', 'accessor' => "EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)"]),
				new DatabaseObjectProperty('lastPurchaseId', ['columnName' => 'purchase_id']),
				new DatabaseObjectProperty('unitsUsed', ['columnName' => 'units_used']),
				new DatabaseObjectProperty('unitsAllowed', ['columnName' => 'units_allowed']),
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'lastPurchaseId');
		$parameters->AddFromFilter($schema, $filters, 'emailId');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->orderBy = $schema->Accessor('expiration') . ' DESC';
	}

	public function jsonSerialize(): mixed {
		return [
			'subscriptionId' => $this->subscriptionId,
			'productId' => $this->productId,
			'productName' => $this->productName,
			'productGameId' => $this->productGameId,
			'productFlags' => $this->productFlags,
			'created' => $this->created,
			'expiration' => $this->expiration,
			'lastPurchaseId' => $this->lastPurchaseId,
			'unitsUsed' => $this->unitsUsed,
			'unitsAllowed' => $this->unitsAllowed,
		];
	}

	public function IsExpired(): bool {
		return $this->expiration <= time();
	}

	public function UnitsUsed(): int {
		return $this->unitsUsed;
	}

	public function UnitsAllowed(): int {
		return $this->unitsAllowed;
	}

	public function UserId(): string {
		return $this->userId;
	}
}

?>

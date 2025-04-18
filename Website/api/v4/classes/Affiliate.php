<?php

namespace BeaconAPI\v4;
use BeaconRecordSet, Exception, JsonSerializable;

class Affiliate extends DatabaseObject implements JsonSerializable {
	protected string $affiliateId;
	protected string $userId;
	protected string $destination;
	protected float $revenueShare;
	protected int $startDate;
	protected int $endDate;
	protected string $description;

	public function __construct(BeaconRecordSet $row) {
		$this->affiliateId = $row->Field('code');
		$this->userId = $row->Field('user_id');
		$this->destination = $row->Field('destination');
		$this->revenueShare = $row->Field('revenue_share');
		$this->startDate = $row->Field('start_date');
		$this->endDate = $row->Field('end_date');
		$this->description = $row->Field('description');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'public',
			table: 'affiliate_links',
			definitions: [
				new DatabaseObjectProperty('affiliateId', ['primaryKey' => true, 'columnName' => 'code']),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('destination'),
				new DatabaseObjectProperty('revenueShare', ['columnName' => 'revenue_share']),
				new DatabaseObjectProperty('startDate', ['columnName' => 'start_date', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('endDate', ['columnName' => 'end_date', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)']),
				new DatabaseObjectProperty('description'),
			]
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'affiliateId');
	}

	public function jsonSerialize(): mixed {
		return [
			'affiliateId' => $this->affiliateId,
			'userId' => $this->userId,
			'destination' => $this->destination,
			'revenueShare' => $this->revenueShare,
			'startDate' => $this->startDate,
			'endDate' => $this->endDate,
			'description' => $this->description,
		];
	}

	public function Code(): string {
		return $this->affiliateId;
	}

	public function RevenueShare(): float {
		return $this->revenueShare;
	}

	public function Description(): string {
		return $this->description;
	}
}

?>

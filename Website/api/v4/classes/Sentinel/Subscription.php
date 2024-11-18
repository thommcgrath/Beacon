<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, User};
use BeaconCommon, BeaconRecordSet, DateInterval, DateTime, Exception, JsonSerializable;

class Subscription extends DatabaseObject implements JsonSerializable {
	protected string $subscriptionId;
	protected string $userId;
	protected string $productId;
	protected int $usedServices;
	protected int $maxServices;
	protected DateInterval $retentionPeriod;
	protected DateInterval $gracePeriod;
	protected DateTime $signupTime;
	protected DateTime $expirationTime;
	protected DateTime $lastRenewalTime;
	protected bool $isSuspended;

	public function __construct(BeaconRecordSet $row) {
		$this->subscriptionId = $row->Field('subscription_id');
		$this->userId = $row->Field('user_id');
		$this->productId = $row->Field('product_id');
		$this->usedServices = $row->Field('used_services');
		$this->maxServices = $row->Field('sentinel_max_services');
		$this->retentionPeriod = new DateInterval($row->Field('sentinel_retention_period'));
		$this->gracePeriod = new DateInterval($row->Field('sentinel_grace_period'));
		$this->signupTime = new DateTime($row->Field('signup_time'));
		$this->expirationTime = new DateTime($row->Field('expiration_time'));
		$this->lastRenewalTime = new DateTime($row->Field('last_renewal_time'));
		$this->isSuspended = $row->Field('suspended');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('sentinel', 'subscriptions', [
			new DatabaseObjectProperty('subscriptionId', ['primaryKey' => true, 'columnName' => 'subscription_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('productId', ['columnName' => 'product_id', 'editable' => DatabaseObjectProperty::kEditableAtCreation]),
			new DatabaseObjectProperty('usedServices', ['columnName' => 'used_services', 'accessor' => '(SELECT COUNT(service_id) FROM sentinel.services WHERE services.subscription_id = %%TABLE%%.subscription_id AND deleted = FALSE)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('maxServices', ['columnName' => 'sentinel_max_services', 'accessor' => 'products.sentinel_max_services', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('retentionPeriod', ['columnName' => 'sentinel_retention_period', 'accessor' => 'public.interval_to_iso8601(products.sentinel_retention_period)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('gracePeriod', ['columnName' => 'sentinel_grace_period', 'accessor' => 'public.interval_to_iso8601(products.sentinel_grace_period)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('signupTime', ['columnName' => 'signup_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('expirationTime', ['columnName' => 'expiration_time', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('lastRenewalTime', ['columnName' => 'last_renewal_time', 'required' => false]),
			new DatabaseObjectProperty('suspended', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
		], [
			'INNER JOIN public.products ON (subscriptions.product_id = products.product_id)',
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('expirationTime');
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'productId');
	}

	public function jsonSerialize(): mixed {
		return [
			'subscriptionId' => $this->subscriptionId,
			'userId' => $this->userId,
			'productId' => $this->productId,
			'usedServices' => $this->usedServices,
			'maxServices' => $this->maxServices,
			'retentionPeriod' => static::BuildIntervalJson($this->retentionPeriod),
			'gracePeriod' => static::BuildIntervalJson($this->gracePeriod),
			'signupTime' => intval($this->signupTime->format('U')),
			'expirationTime' => intval($this->expirationTime->format('U')),
			'lastRenewalTime' => intval($this->lastRenewalTime->format('U')),
			'isSuspended' => $this->isSuspended,
		];
	}

	public function SubscriptionId(): string {
		return $this->subscriptionId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function ProductId(): string {
		return $this->productId;
	}

	public function UsedServices(): int {
		return $this->usedServices;
	}

	public function MaxServices(): int {
		return $this->maxServices;
	}

	public function RetentionPeriod(): DateInterval {
		return $this->retentionPeriod;
	}

	public function GracePeriod(): DateInterval {
		return $this->gracePeriod;
	}

	public function SignupTime(): DateTime {
		return $this->signupTime;
	}

	public function ExpirationTime(): DateTime {
		return $this->expirationTime;
	}

	public function LastRenewalTime(): DateTime {
		return $this->lastRenewalTime;
	}

	public function IsSuspended(): bool {
		return $this->isSuspended;
	}

	protected static function BuildIntervalJson(DateInterval $interval): array {
		$isoPieces = ['P'];
		$obj = [];
		if ($interval->y > 0) {
			$isoPieces[] = $interval->format('%yY');
			$obj['years'] = $interval->y;
		}
		if ($interval->m > 0) {
			$isoPieces[] = $interval->format('%mM');
			$obj['months'] = $interval->m;
		}
		if ($interval->d > 0) {
			$isoPieces[] = $interval->format('%dD');
			$obj['days'] = $interval->d;
		}
		if ($interval->h > 0 || $interval->i > 0 || $interval->s > 0) {
			$isoPieces[] = 'T';
		}
		if ($interval->h > 0) {
			$isoPieces[] = $interval->format('%hH');
			$obj['hours'] = $interval->h;
		}
		if ($interval->i > 0) {
			$isoPieces[] = $interval->format('%iM');
			$obj['minutes'] = $interval->i;
		}
		if ($interval->s > 0) {
			$isoPieces[] = $interval->format('%sS');
			$obj['seconds'] = $interval->s;
		}
		if (count($isoPieces) === 1) {
			$isoPieces[] = '0S';
		}
		$obj['iso8601'] = implode('', $isoPieces);

		return $obj;
	}
}

?>

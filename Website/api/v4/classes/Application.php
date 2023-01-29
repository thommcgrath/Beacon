<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class Application extends DatabaseObject implements JsonSerializable {
	protected $applicationId = null;
	protected $userId = null;
	protected $secret = null;
	protected $name = null;
	protected $website = null;
	protected $scopes = [];
	protected $callbacks = [];
	
	const kScopePasswordAuth = 'password_auth';
	const kScopeCommon = 'common';
	const kScopeAppsRead = 'apps:read';
	const kScopeAppsWrite = 'apps:write';
	const kScopeSentinelLogsRead = 'sentinel_logs:read';
	const kScopeSentinelLogsWrite = 'sentinel_logs:write';
	const kScopeSentinelPlayersRead = 'sentinel_players:read';
	const kScopeSentinelPlayersWrite = 'sentinel_players:write';
	const kScopeSentinelServicesRead = 'sentinel_services:read';
	const kScopeSentinelServicesWrite = 'sentinel_services:write';
	const kScopeUserRead = 'user:read';
	const kScopeUserWrite = 'user:write';
	
	public static function ValidScopes(): array {
		return [
			self::kScopePasswordAuth,
			self::kScopeCommon,
			self::kScopeAppsRead,
			self::kScopeAppsWrite,
			self::kScopeSentinelLogsRead,
			self::kScopeSentinelLogsWrite,
			self::kScopeSentinelPlayersRead,
			self::kScopeSentinelPlayersWrite,
			self::kScopeSentinelServicesRead,
			self::kScopeSentinelServicesWrite,
			self::kScopeUserRead,
			self::kScopeUserWrite
		];
	}
		
	public function __construct(BeaconRecordSet $row) {
		$this->applicationId = $row->Field('application_id');
		$this->userId = $row->Field('user_id');
		$this->secret = BeaconEncryption::SymmetricDecrypt(BeaconCommon::GetGlobal('App Secret Encryption Key'), base64_decode($row->Field('secret')));
		$this->name = $row->Field('name');
		$this->website = $row->Field('website');
		$this->scopes = explode(' ', $row->Field('scopes'));
		$this->callbacks = json_decode($row->Field('callbacks'), true);
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'applications', [
			new DatabaseObjectProperty('applicationId', ['primaryKey' => true, 'columnName' => 'application_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('secret'),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('website'),
			new DatabaseObjectProperty('scopes'),
			new DatabaseObjectProperty('callbacks', ['columnName' => 'callbacks', 'accessor' => "(SELECT COALESCE(array_to_json(array_agg(callbacks_template.url)), '[]') FROM (SELECT url FROM application_callbacks WHERE application_id = applications.application_id ORDER BY url) AS callbacks_template)"])
		]);
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->orderBy = $schema->Accessor('name');
	}
	
	public static function Create(array $properties): static {
		if (BeaconCommon::HasAllKeys($properties, 'name', 'website', 'scopes', 'callbacks', 'userId') === false) {
			throw new Exception('Missing required properties');
		}
		
		$applicationId = BeaconCommon::GenerateUUID();
		$secret = BeaconCommon::GenerateUUID();
		$secretEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt(BeaconCommon::GetGlobal('App Secret Encryption Key'), $secret));
		$scopes = $properties['scopes'];
		$callbacks = $properties['callbacks'];
		$name = $properties['name'];
		$website = $properties['website'];
		$userId = $properties['userId'];
		
		$validScopes = static::ValidScopes();
		foreach ($scopes as $scope) {
			if (in_array($scope, $validScopes) === false) {
				throw new Exception("Invalid scope {$scope}");
			}
		}
		if (in_array(self::kScopeCommon, $scopes) === false) {
			$scopes[] = self::kScopeCommon;
		}
		sort($scopes);
		
		foreach ($callbacks as $url) {
			if (filter_var($url, FILTER_VALIDATE_URL) === false) {
				throw new Exception("Invalid url '{$url}'");
			}
			if (str_starts_with($url, 'https://') === false) {
				throw new Exception("Url '{$url}' must use HTTPS");
			}
		}
		
		if (filter_var($website, FILTER_VALIDATE_URL) === false) {
			throw new Exception("Invalid url '{$website}'");
		}
		if (str_starts_with($website, 'https://') === false) {
			throw new Exception("Url '{$website}' must use HTTPS");
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.applications (application_id, secret, name, website, user_id, scopes) VALUES ($1, $2, $3, $4, $5, $6);", $applicationId, $secretEncrypted, $name, $website, $userId, implode(' ', $scopes));
		foreach ($callbacks as $url) {
			$database->Query("INSERT INTO public.application_callbacks (application_id, url) VALUES ($1, $2);", $applicationId, $url);
		}
		$database->Commit();
		
		return static::Fetch($applicationId);
	}
	
	public function Edit(array $properties): void {
		$placeholder = 2;
		$assignments = [];
		$values = [$this->applicationId];
		if (isset($properties['name']) && $properties['name'] !== $this->name) {
			$assignments[] = 'name = $' . $placeholder++;
			$values[] = $properties['name'];
		}
		
		if (isset($properties['website']) && $properties['website'] !== $this->website) {
			$website = $properties['website'];
			if (filter_var($website, FILTER_VALIDATE_URL) === false) {
				throw new Exception("Invalid url '{$website}'");
			}
			if (str_starts_with($website, 'https://') === false) {
				throw new Exception("Url '{$website}' must use HTTPS");
			}
			$assignments[] = 'website = $' . $placeholder++;
			$values[] = $website;
		}
		
		if (isset($properties['secret']) && $properties['secret'] !== $this->secret) {
			$secret = BeaconCommon::GenerateUUID();
			$secretEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt(BeaconCommon::GetGlobal('App Secret Encryption Key'), $secret));
			$assignments[] = 'secret = $' . $placeholder++;
			$values[] = $secretEncrypted;
		}
		
		$scopesToRemove = [];
		if (isset($properties['scopes'])) {
			$scopes = $properties['scopes'];
			if (is_array($scopes) === false) {
				throw new Exception('Scopes is not an array');
			}
			
			$validScopes = static::ValidScopes();
			foreach ($scopes as $scope) {
				if (in_array($scope, $validScopes) === false) {
					throw new Exception("Invalid scope {$scope}");
				}
			}
			if (in_array(self::kScopeCommon, $scopes) === false) {
				$scopes[] = self::kScopeCommon;
			}
			
			sort($scopes);
			$assignments[] = 'scopes = $' . $placeholder++;
			$values[] = implode(' ', $scopes);
			
			$scopesToRemove = array_diff($this->scopes, $scopes);
		}
		
		$callbacksToAdd = [];
		$callbacksToRemove = [];
		if (isset($properties['callbacks'])) {
			$callbacks = $properties['callbacks'];
			if (is_array($callbacks) === false) {
				throw new Exception('Callbacks is not an array');
			}
			
			foreach ($callbacks as $url) {
				if (filter_var($url, FILTER_VALIDATE_URL) === false) {
					throw new Exception("Invalid url '{$url}'");
				}
				if (str_starts_with($url, 'https://') === false) {
					throw new Exception("Url '{$url}' must use HTTPS");
				}
			}
			
			$callbacksToAdd = array_diff($callbacks, $this->callbacks);
			$callbacksToRemove = array_diff($this->callbacks, $callbacks);
		}
		
		if (count($assignments) === 0 && count($scopesToAdd) === 0 && count($scopesToRemove) === 0 && count($callbacksToAdd) === 0 && count($callbacksToRemove) === 0) {
			return;
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("UPDATE public.applications SET " . implode(', ', $assignments) . " WHERE application_id = $1;", $values);
		foreach ($callbacksToAdd as $url) {
			$database->Query("INSERT INTO public.application_callbacks (application_id, url) VALUES ($1, $2);", $this->applicationId, $url);
		}
		foreach ($callbacksToRemove as $url) {
			$database->Query("DELETE FROM public.application_callbacks WHERE application_id = $1 AND url = $2;", $this->applicationId, $url);
		}
		
		// Since scopes are being removed, we need to adjust sessions accordingly
		foreach ($scopesToRemove as $scope) {
			$rows = $database->Query("SELECT session_id, scopes FROM public.sessions WHERE application_id = $1 AND scopes LIKE $1;", $this->applicationId, $scope);
			while (!$rows->EOF()) {
				$sessionHash = $rows->Field('session_id');
				$scopes = str_replace($scope, '', $rows->Field('scopes'));
				$scopes = str_replace('  ', ' ', $scopes);
				if (empty($scopes)) {
					$database->Query("DELETE FROM public.sessions WHERE session_id = $1;", $sessionHash);
				} else {
					$database->Query("UPDATE public.sessions SET scopes = $2 WHERE session_id = $1;", $sessionHash, $scopes);
				}
				$rows->MoveNext();
			}
		}
		
		$database->Commit();
		
		$schema = static::DatabaseSchema();
		$rows = $database->Query('SELECT ' . $schema->SelectColumns() . ' FROM ' . $schema->FromClause() . ' WHERE ' . $schema->PrimaryAccessor() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->applicationId);
		$this->__construct($rows);
	}
	
	public function ApplicationId(): string {
		return $this->applicationId;	
	}
	
	public function UserId(): string {
		return $this->userId;
	}
	
	public function Secret(): string {
		return $this->secret;
	}
	
	public function Name(): string {
		return $this->name;
	}
	
	public function IconUrl(): string {
		return '';
	}
	
	public function Website(): string {
		return $this->website;
	}
	
	public function Scopes(): array {
		return $this->scopes;
	}
	
	public function Callbacks(): array {
		return $this->callbacks;
	}
	
	public function HasScope(string $scope): bool {
		return in_array($scope, $this->scopes);
	}
	
	public function HasScopes(array $scopes): bool {
		if (count($scopes) === 0) {
			return false;
		}
		
		foreach ($scopes as $scope) {
			if ($this->HasScope($scope) === false) {
				return false;
			}
		}
		
		return true;
	}
	
	public function CallbackAllowed(string $url): bool {
		return in_array($url, $this->callbacks);
	}
	
	public function BeginLogin(array $scopes, string $callback, string $state): ?string {
		if ($this->CallbackAllowed($callback) === false) {
			return null;
		}
		
		if (in_array(self::kScopeCommon, $scopes) === false) {
			$scopes[] = self::kScopeCommon;
		}
		if ($this->HasScopes($scopes) === false) {
			return null;
		}
		
		$loginId = BeaconCommon::GenerateUUID();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.application_logins (login_id, application_id, scopes, callback, state) VALUES ($1, $2, $3, $4, $5);", $loginId, $this->applicationId, implode(' ', $scopes), $callback, $state);
		$database->Commit();
		
		return $loginId;
	}
	
	public function IssueGrantCode(string $loginId, string $userId): ?string {
		$url = null;
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("DELETE FROM public.application_logins WHERE expiration < CURRENT_TIMESTAMP;");
		$rows = $database->Query("SELECT callback, state FROM public.application_logins WHERE login_in = $1 AND expiration > CURRENT_TIMESTAMP AND code IS NULL;", $loginId);
		if ($rows->RecordCount() === 1) {
			$code = BeaconCommon::GenerateUUID();
			$codeHash = $this->HashGrantCode($code);
			$database->Query("UPDATE public.application_logins SET user_id = $2, code = $3, expiration = CURRENT_TIMESTAMP(0) + '5 minutes'::INTERVAL WHERE login_id = $1;", $loginId, $userId, $codeHash);
			
			$url = $rows->Field('callback');
			if (str_contains($url, '?')) {
				$url .= '&';
			} else {
				$url .= '?';
			}
			$url .= 'code=' . urlencode($code) . '&state=' . urlencode($rows->Field('state'));
		}
		$database->Commit();
		return $url;
	}
	
	public function RedeemGrantCode(string $code): ?Session {
		$codeHash = $this->HashGrantCode($code);
		$database = BeaconCommon::Database();
		$rows = $database->Query("SELECT * FROM public.application_logins WHERE application_id = $1 AND code = $2 AND expiration > CURRENT_TIMESTAMP;", $this->applicationId, $codeHash);
		if ($rows->RecordCount() !== 1) {
			return null;
		}
		$loginId = $rows->Field('login_id');
		$userId = $rows->Field('user_id');
		$scopes = explode($rows->Field('scopes'));
		$user = User::Fetch($userId);
		if (is_null($user)) {
			// This should be impossible thanks to foreign key constraints
			return null;
		}
		$database->BeginTransaction();
		$session = Session::Create($user, $this, $scopes);
		$database->Query("DELETE FROM public.application_logins WHERE login_id = $1 OR expiration < CURRENT_TIMESTAMP;", $loginId);
		$database->Commit();
		return $session;
	}
	
	protected function HashGrantCode(string $code): string {
		return base64_encode(hash('sha3-512', "{$this->applicationId}.{$code}", true));
	}
	
	public function jsonSerialize(): mixed {
		return [
			'applicationId' => $this->applicationId,
			'name' => $this->name,
			'secret' => $this->secret,
			'iconUrl' => $this->IconUrl(),
			'website' => $this->website,
			'scopes' => $this->scopes,
			'callbacks' => $this->callbacks
		];
	}
}

?>

<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class Application extends DatabaseObject implements JsonSerializable {
	protected $applicationId = null;
	protected $userId = null;
	protected $secret = null;
	protected $name = null;
	protected $website = null;
	protected $iconBaseName = null;
	protected $iconFormat = null;
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
		$this->iconBaseName = $row->Field('icon_base_filename');
		$this->iconFormat = $row->Field('icon_format');
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
			new DatabaseObjectProperty('iconBaseName', ['columnName' => 'icon_base_filename']),
			new DatabaseObjectProperty('iconFormat', ['columnName' => 'icon_format']),
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
		
		if (count($assignments) === 0 && count($scopesToRemove) === 0 && count($callbacksToAdd) === 0 && count($callbacksToRemove) === 0) {
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
			$rows = $database->Query("SELECT DISTINCT scopes FROM public.sessions WHERE application_id = $1 AND scopes LIKE $1; AND valid_valut < CURRENT_TIMESTAMP", $this->applicationId, "%{$scope}%");
			while (!$rows->EOF()) {
				$oldScopes = $rows->Field('scopes');
				$newScopes = str_replace($scope, '', $oldScopes);
				$newScopes = str_replace('  ', ' ', $newScopes);
				if (empty($newScopes)) {
					$database->Query("DELETE FROM public.sessions WHERE application_id = $1 AND scopes = $1 AND valid_until < CURRENT_TIMESTAMP;", $this->applicationId, $oldScopes);
				} else {
					$database->Query("UPDATE public.sessions SET scopes = $3 WHERE application_id = $1 AND scopes = $1;", $this->applicationId, $oldScopes, $newScopes);
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
	
	public function IconUrl(?int $size = null): string {
		$suffix = '';
		if ($this->iconFormat === 'svg') {
			// size is irrelevant
		} else if (is_null($size)) {
			$suffix = '_original';
		} else if ($size <= 32) {
			$suffix = '_32px';
		} else if ($size <= 64) {
			$suffix = '_64px';
		} else if ($size <= 128) {
			$suffix = '_128px';
		} else if ($size <= 256) {
			$suffix = '_256px';
		} else if ($size <= 512) {
			$suffix = '_512px';
		} else {
			$suffix = '_1024px';
		}
		
		// Don't panic, uploading an avatar sets the iconBaseName to appId/avatar. This way we can
		// keep default/common icons too though.
		return "https://assets.usebeacon.app/avatars/{$this->iconBaseName}{$suffix}.{$this->iconFormat}";
	}
	
	public function IconHtml(int $size): string {
		if ($this->iconFormat === 'svg') {
			return '<img src="' . htmlentities($this->IconUrl()) . '" width="' . $size . '" height="' . $size . '" alt="">';
		} else {
			return '<img src="' . htmlentities($this->IconUrl($size)) . '" srcset="' . htmlentities($this->IconUrl($size)) . ', ' . htmlentities($this->IconUrl($size * 2)) . ' 2x, ' . htmlentities($this->IconUrl($size * 3)) . ' 3x" width="' . $size . '" height="' . $size . '" alt="">';
		}
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

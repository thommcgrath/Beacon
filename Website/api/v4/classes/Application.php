<?php

namespace BeaconAPI\v4;
use BeaconCDN, BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, Imagick, JsonSerializable;

class Application extends DatabaseObject implements JsonSerializable {
	protected string $applicationId = '';
	protected string $userId = '';
	protected ?string $secret = null;
	protected string $name = '';
	protected string $website = '';
	protected string $iconFilename = '';
	protected array $scopes = [];
	protected array $callbacks = [];
	protected int $rateLimit = 50;
	protected bool $isOfficial = false;
	protected int $experience = 0;
	protected bool $secretIsDecrypted = false;

	const kScopeCommon = 'common';
	const kScopeAppsCreate = 'apps:create';
	const kScopeAppsRead = 'apps:read';
	const kScopeAppsUpdate = 'apps:update';
	const kScopeAppsDelete = 'apps:delete';
	const kScopeAuthPublicKey = 'auth.public_key:create';
	const kScopeUsersCreate = 'users:create';
	const kScopeUsersRead = 'users:read';
	const kScopeUsersUpdate = 'users:update';
	const kScopeUsersDelete = 'users:delete';
	const kScopeUsersPrivateKeyRead = 'users.private_key:read';
	const kScopeSentinelRead = 'sentinel:read';
	const kScopeSentinelWrite = 'sentinel:write';
	const kScopeUsersBilling = 'users.billing';

	const kExperienceAppWebView = 1;

	const SecretLength = 48;

	public static function ValidScopes(): array {
		return [
			self::kScopeCommon,
			self::kScopeAppsCreate,
			self::kScopeAppsRead,
			self::kScopeAppsUpdate,
			self::kScopeAppsDelete,
			self::kScopeAuthPublicKey,
			self::kScopeUsersCreate,
			self::kScopeUsersRead,
			self::kScopeUsersUpdate,
			self::kScopeUsersDelete,
			self::kScopeUsersPrivateKeyRead,
			self::kScopeSentinelRead,
			self::kScopeSentinelWrite,
			self::kScopeUsersBilling,
		];
	}

	public static function RestrictedScopes(): array {
		return [
			self::kScopeUsersCreate,
			self::kScopeUsersUpdate,
			self::kScopeUsersDelete,
			self::kScopeUsersPrivateKeyRead,
			self::kScopeAppsCreate,
			self::kScopeAppsRead,
			self::kScopeAppsUpdate,
			self::kScopeAppsDelete,
			self::kScopeAuthPublicKey,
			self::kScopeUsersBilling,
		];
	}

	public function __construct(BeaconRecordSet $row) {
		$this->applicationId = $row->Field('application_id');
		$this->userId = $row->Field('user_id');
		if (is_null($row->Field('secret')) === false) {
			$this->secret = $row->Field('secret');
		}
		$this->name = $row->Field('name');
		$this->website = $row->Field('website');
		$this->iconFilename = $row->Field('icon_filename');
		$this->scopes = explode(' ', $row->Field('scopes'));
		$this->callbacks = json_decode($row->Field('callbacks'), true);
		$this->rateLimit = filter_var($row->Field('rate_limit'), FILTER_VALIDATE_INT);
		$this->isOfficial = filter_var($row->Field('is_official'), FILTER_VALIDATE_BOOL);
		$this->experience = filter_var($row->Field('experience'), FILTER_VALIDATE_INT);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'applications', [
			new DatabaseObjectProperty('applicationId', ['primaryKey' => true, 'columnName' => 'application_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('secret'),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('website'),
			new DatabaseObjectProperty('iconFilename', ['columnName' => 'icon_filename']),
			new DatabaseObjectProperty('scopes'),
			new DatabaseObjectProperty('callbacks', ['columnName' => 'callbacks', 'accessor' => "(SELECT COALESCE(array_to_json(array_agg(callbacks_template.url)), '[]') FROM (SELECT url FROM application_callbacks WHERE application_id = applications.application_id ORDER BY url) AS callbacks_template)"]),
			new DatabaseObjectProperty('rateLimit', ['columnName' => 'rate_limit']),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'is_official']),
			new DatabaseObjectProperty('experience')
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->orderBy = $schema->Accessor('name');
	}

	public static function Create(array $properties): static {
		if (BeaconCommon::HasAllKeys($properties, 'name', 'website', 'scopes', 'callbacks', 'userId') === false) {
			throw new Exception('Missing required properties');
		}

		$applicationId = $properties['applicationId'] ?? BeaconCommon::GenerateUUID();
		$generateSecret = isset($properties['secret']);
		if ($generateSecret) {
			$secret = BeaconCommon::GenerateRandomKey(self::SecretLength);
			$secretEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt(BeaconCommon::GetGlobal('Auth Encryption Key'), $secret));
		} else {
			$secret = null;
			$secretEncrypted = null;
		}
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
		$restrictedScopes = array_intersect($scopes, static::RestrictedScopes());
		if (count($restrictedScopes) > 0) {
			sort($restrictedScopes);
			$restrictedScope = BeaconCommon::ArrayToEnglish($restrictedScopes);
			$scopeOrScopes = count($restrictedScopes) > 1 ? 'scopes' : 'scope';
			throw new Exception("This app has requested the restricted {$scopeOrScopes} {$restrictedScope}. Create the app without the {$scopeOrScopes}, then contact support to discuss gaining access.");
		}
		sort($scopes);

		foreach ($callbacks as $url) {
			if (filter_var($url, FILTER_VALIDATE_URL) === false) {
				throw new Exception("Invalid callback url '{$url}'");
			}
			if (str_starts_with($url, 'https://') === false) {
				throw new Exception("Url '{$url}' must use HTTPS");
			}
		}

		if (filter_var($website, FILTER_VALIDATE_URL) === false) {
			throw new Exception("Invalid website url '{$website}'");
		}
		if (str_starts_with($website, 'https://') === false) {
			throw new Exception("Url '{$website}' must use HTTPS");
		}

		// Since this uploads images, only do it after all other checks have passed
		$iconFilename = static::SaveIconData($applicationId, $properties['iconData'] ?? '');

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query("INSERT INTO public.applications (application_id, secret, name, website, user_id, scopes, is_official, icon_filename) VALUES ($1, $2, $3, $4, $5, $6, FALSE, $7);", $applicationId, $secretEncrypted, $name, $website, $userId, implode(' ', $scopes), $iconFilename);
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

		if (isset($properties['iconFilename']) && $properties['iconFilename'] !== $this->iconFilename) {
			$assignments[] = 'icon_filename = $' . $placeholder++;
			$values[] = $properties['iconFilename'];
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

		if (isset($properties['secret']) && $properties['secret'] !== $this->Secret()) {
			if (is_null($properties['secret'])) {
				$secret = null;
				$secretEncrypted = null;
			} else {
				// Including any non-null value will generate a new secret. Don't accept the provided secret.
				$secret = BeaconCommon::GenerateRandomKey(self::SecretLength);
				$secretEncrypted = base64_encode(BeaconEncryption::SymmetricEncrypt(BeaconCommon::GetGlobal('Auth Encryption Key'), $secret));
			}
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

			$scopesToAdd = array_diff($scopes, $this->scopes);
			$restrictedScopes = array_intersect($scopesToAdd, static::RestrictedScopes());
			if (count($restrictedScopes) > 0) {
				sort($restrictedScopes);
				$restrictedScope = BeaconCommon::ArrayToEnglish($restrictedScopes);
				$scopeOrScopes = count($restrictedScopes) > 1 ? 'scopes' : 'scope';
				throw new Exception("This app has requested the restricted {$scopeOrScopes} {$restrictedScope}. Create the app without the {$scopeOrScopes}, then contact support to discuss gaining access.");
			}

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

		if (isset($properties['iconData'])) {
			$values[] = static::SaveIconData($this->applicationId, $properties['iconData']);
			$assignments[] = 'icon_filename = $' . $placeholder++;
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

	public function Delete(): void {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.applications WHERE application_id = $1;', $this->applicationId);
		$database->Commit();

		if ($this->iconFilename === '{{applicationId}}/{{size}}.png') {
			try {
				$cdn = BeaconCDN::AssetsZone();
				$cdn->DeleteFile("/images/avatars/{$this->applicationId}/");
			} catch (Exception $err) {
			}
		}
	}

	protected static function SaveIconData(string $applicationId, string $base64IconData): string {
		try {
			$iconData = base64_decode($base64IconData);
			if ($iconData === false) {
				throw new Exception('Bad base64 data');
			}

			$sizes = [32, 64, 128, 256, 512, 1024];
			$source = new Imagick();
			$source->readImageBlob($iconData);
			$imageInfo = $source->identifyImage();
			switch ($imageInfo['mimetype']) {
			case 'image/png':
				$extension = 'png';
				break;
			case 'image/x-psd':
				$extension = 'psd';
				break;
			case 'image/jpeg':
				$extension = 'jpg';
				break;
			case 'image/tiff':
				$extension = 'tiff';
				break;
			case 'image/x-webp':
				$extension = 'webp';
				break;
			case 'image/gif':
				$extension = 'gif';
				break;
			default:
				throw new Exception('Unknown mime type ' . $imageInfo['mimetype']);
				break;
			}
			$cdn = BeaconCDN::AssetsZone();

			foreach ($sizes as $size) {
				$image = clone $source;
				$image->setImageFormat('png');
				$image->setBackgroundColor('#ffffff');
				$image->thumbnailImage($size, $size, true, true);

				$cdn->PutFile("/images/avatars/{$applicationId}/{$size}px.png", $image->getImageBlob());

				$image->destroy();
			}

			$cdn->PutFile("images/avatars/{$applicationId}/original.{$extension}", $iconData);
			return "{{applicationId}}/{{size}}.png";
		} catch (Exception $err) {
			return "default/{{size}}.png";
		}
	}

	public function ApplicationId(): string {
		return $this->applicationId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Secret(): ?string {
		if (is_null($this->secret)) {
			return null;
		}
		if ($this->secretIsDecrypted) {
			return $this->secret;
		}

		try {
			$this->secret = BeaconEncryption::SymmetricDecrypt(BeaconCommon::GetGlobal('Auth Encryption Key'), base64_decode($this->secret));
			$this->secretIsDecrypted = true;
		} catch (Exception $err) {
		}
		return $this->secret;
	}

	public function CheckSecret(?string $secret): bool {
		return is_null($secret) === false && $this->Secret() === $secret;
	}

	public function Name(): string {
		return $this->name;
	}

	public function IconFilename(): string {
		return $this->iconFilename;
	}

	public function IconUrl(?int $size = null): string {
		if (is_null($size)) {
			$size = 1024;
		}
		if ($size <= 32) {
			$sizeSpec = '32px';
		} else if ($size <= 64) {
			$sizeSpec = '64px';
		} else if ($size <= 128) {
			$sizeSpec = '128px';
		} else if ($size <= 256) {
			$sizeSpec = '256px';
		} else if ($size <= 512) {
			$sizeSpec = '512px';
		} else {
			$sizeSpec = '1024px';
		}

		$filename = str_replace(['{{applicationId}}', '{{size}}'], [$this->applicationId, $sizeSpec], $this->iconFilename);
		return "https://assets.usebeacon.app/images/avatars/{$filename}";
	}

	public function IconHtml(int $size): string {
		if (str_ends_with($this->iconFilename, '.svg')) {
			return '<img class="avatar" src="' . htmlentities($this->IconUrl()) . '" width="' . $size . '" height="' . $size . '" alt="">';
		} else {
			return '<img class="avatar" src="' . htmlentities($this->IconUrl($size)) . '" srcset="' . htmlentities($this->IconUrl($size)) . ', ' . htmlentities($this->IconUrl($size * 2)) . ' 2x, ' . htmlentities($this->IconUrl($size * 3)) . ' 3x" width="' . $size . '" height="' . $size . '" alt="">';
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
			return true;
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

	public function RequestLimitPerMinute(): int {
		return $this->rateLimit;
	}

	public function IsConfidential(): bool {
		return is_null($this->secret) === false;
	}

	public function IsOfficial(): bool {
		return $this->isOfficial;
	}

	public function Experience(): int {
		return $this->experience;
	}

	public function jsonSerialize(): mixed {
		return [
			'applicationId' => $this->applicationId,
			'name' => $this->name,
			'iconUrl' => $this->IconUrl(),
			'iconUrls' => [
				'32' => $this->IconUrl(32),
				'64' => $this->IconUrl(64),
				'128' => $this->IconUrl(128),
				'256' => $this->IconUrl(256),
				'512' => $this->IconUrl(512),
				'1024' => $this->IconUrl(1024),
			],
			'website' => $this->website,
			'scopes' => $this->scopes,
			'callbacks' => $this->callbacks,
			'rateLimit' => $this->rateLimit,
			'isOfficial' => $this->isOfficial,
			'experience' => $this->experience
		];
	}
}

?>

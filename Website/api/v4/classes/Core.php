<?php

namespace BeaconAPI\v4;
use BeaconCache, BeaconCommon, BeaconLogin, BeaconRateLimits, DateTime, Exception, Throwable;

class Core {
	const kAuthSchemeBearer = 'Bearer';
	const kAuthSchemeDigest = 'Digest';
	const kAuthSchemeNone = 'None';
	
	const kUnauthorized = 0;
	const kAuthorized = 1;
	const kAuthErrorNoToken = 2;
	const kAuthErrorMalformedToken = 3;
	const kAuthErrorInvalidToken = 4;
	const kAuthErrorRestrictedScope = 5;
	
	protected static $session = null;
	protected static $application = null;
	protected static $payload = null;
	protected static $body_raw = null;
	protected static $routes = [];
	
	public static function HandleCors(): void {
		header('Access-Control-Allow-Origin: *');
		header('Access-Control-Allow-Methods: DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT');
		header('Access-Control-Allow-Headers: DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,X-Beacon-Upgrade-Encryption,X-Beacon-Token,Authorization');
		header('Access-Control-Expose-Headers: Content-Length,Content-Range');
		header('Vary: Origin');
		
		if (static::Method() === 'OPTIONS') {
			header('Access-Control-Max-Age: 1728000');
			http_response_code(204);
			exit;
		}
	}
	
	public static function ApiVersionNumber(): int {
		return 4;
	}
	
	public static function ApiVersion(): string {
		return 'v4';
	}
	
	public static function UsesLegacyEncryption(): bool {
		return false;
	}
	
	public static function Body() {
		if (static::$body_raw === null) {
			if (static::Method() == 'GET') {
				static::$body_raw = $_SERVER['QUERY_STRING'];
			} else {
				static::$body_raw = file_get_contents('php://input');
			}
			if (isset($_SERVER['HTTP_CONTENT_ENCODING']) && $_SERVER['HTTP_CONTENT_ENCODING'] == 'gzip') {
				static::$body_raw = gzdecode(static::$body_raw);
			}
		}
		return static::$body_raw;
	}
	
	public static function ContentType(): string {
		if (isset($_SERVER['HTTP_CONTENT_TYPE']) === false) {
			return '';
		}
		
		return strtok(strtolower($_SERVER['HTTP_CONTENT_TYPE']), ';');
	}
	
	public static function IsJsonContentType(): bool {
		return static::ContentType() === 'application/json';
	}
	
	public static function BodyAsJson() {
		if (static::$payload === null) {
			static::$payload = json_decode(static::Body(), true);
		}
		return static::$payload;
	}
	
	// deprecated
	public static function ReplySuccess(mixed $payload = null): void {
		if (empty($payload)) {
			Response::NewNoContent()->Flush();
		} else {
			Response::NewJson($payload, $code)->Flush();
		}
		exit;
	}
	
	// deprecated
	public static function ReplyError(string $message, mixed $payload = null, int $code) {
		Response::NewJsonError($message, $payload, $code)->Flush();
		exit;
	}
	
	public static function RequireKeys(string ...$keys) {
		$request = static::JSONPayload();
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($request[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			static::ReplyError('Missing required keys.', $missing);
		}
	}
	
	public static function RequireParams(string ...$keys) {
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($_GET[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			static::ReplyError('Missing required parameters.', $missing);
		}
	}
	
	public static function Method() {
		return strtoupper($_SERVER['REQUEST_METHOD']);
	}
	
	public static function Authorize(string $scheme, string ...$requestedScopes): void {
		$supportedScopes = [];
		$requiredScopes = [];
		switch ($scheme) {
		case self::kAuthSchemeBearer:
			$supportedScopes = [
				Application::kScopeCommon,
				Application::kScopeAppsCreate,
				Application::kScopeAppsRead,
				Application::kScopeAppsUpdate,
				Application::kScopeAppsDelete,
				Application::kScopeUsersRead,
				Application::kScopeUsersUpdate,
				Application::kScopeUsersDelete,
				Application::kScopeSentinelLogsRead,
				Application::kScopeSentinelLogsUpdate,
				Application::kScopeSentinelPlayersRead,
				Application::kScopeSentinelPlayersUpdate,
				Application::kScopeSentinelServicesCreate,
				Application::kScopeSentinelServicesRead,
				Application::kScopeSentinelServicesUpdate,
				Application::kScopeSentinelServicesDelete
			];
			$requiredScopes = [
				Application::kScopeCommon
			];
			break;
		case self::kAuthSchemeDigest:
			$supportedScopes = [
				Application::kScopePasswordAuth,
				Application::kScopeUsersCreate
			];
			$requiredScopes = [];
			break;
		}
		
		$disallowedScopes = array_diff($requestedScopes, $supportedScopes);
		$missingScopes = array_diff($requestedScopes, $requiredScopes);
		$hasScopeViolations = count($disallowedScopes) > 0 || count($missingScopes) > 0;
		$httpStatus = ($hasScopeViolations) ? 403 : 401;
		$message = $httpStatus === 401 ? 'Unauthorized' : 'Forbidden';
		$authStatus = self::kUnauthorized;
			
		$realm = 'Beacon API';
		$authParams = [$scheme, 'realm="' . $realm . '"'];
		
		if ($hasScopeViolations === false) {
			switch ($scheme) {
			case self::kAuthSchemeBearer:
				$authStatus = static::AuthenticateWithBearer($requestedScopes);
				if ($authStatus === self::kAuthorized) {
					return;
				}
				
				switch ($authStatus) {
				case self::kAuthErrorMalformedToken:
				case self::kAuthErrorInvalidToken:
					$authParams[] = 'error="invalid_token"';
					$authParams[] = 'error_description="The access token is invalid, expired, or malformed."';
					break;
				case self::kAuthErrorRestrictedScope:
					$authParams[] = 'error="insufficient_scope"';
					$authParams[] = 'error_description="The access token is valid but does not include the required scopes."';
					$authParams[] = 'scope="' . implode(' ', $requestedScopes) . '"';
					break;
				}
				
				break;
			case self::kAuthSchemeDigest:
				// Used for requests like POST /emailVerification/{emailAddress} that are not performed on behalf of a user.
				$cacheKey = hash('sha1', BeaconCommon::RemoteAddr(false));
				$authStatus = static::AuthenticateWithDigest($cacheKey, $realm, $requestedScopes);
				if ($authStatus === self::kAuthorized) {
					return;
				}
				
				$nonce = BeaconCommon::GenerateUUID();
				BeaconCache::Set($cacheKey, $nonce, 120);
				
				$authParams[] = 'qop="auth"';
				$authParams[] = 'nonce="' . $nonce . '"';
				$authParams[] = 'opaque="' . md5($realm) . '"';
				break;
			case self::kAuthSchemeNone:
				return;
			}
		}
		
		header('WWW-Authenticate: ' . implode(' ', $authParams));
		
		static::ManageRateLimit();
		Response::NewJsonError($message, null, $httpStatus)->Flush();
		exit;
	}
	
	public static function RequestScopes(array ...$scopes): void {
		if (count($scopes) === 0) {
			throw new Exception('Did not request any scopes to authorize');
		}
		
		if (is_null(static::$session)) {
			throw new Exception('Unauthorized');
		}
		
		if (static::$session->HasScopes($scopes) === false) {
			throw new Exception('Scopes not authorized');
		}
	}
	
	protected static function AuthenticateWithBearer(array $requestedScopes): int {
		$header = $_SERVER['HTTP_AUTHORIZATION'] ?? 'Bearer ' . ($_SERVER['HTTP_X_BEACON_TOKEN'] ?? '');
		$scheme = strtok($header, ' ');
		
		if ($scheme !== self::kAuthSchemeBearer) {
			return self::kUnauthorized;
		}
		
		$token = strtok(' ');
		if (empty($token)) {
			return self::kAuthErrorNoToken;
		}
		
		$session = null;
		try {
			$session = Session::Fetch($token);
		} catch (Exception $err) {
			return self::kAuthErrorMalformedToken;
		}
		if (is_null($session)) {
			return self::kAuthErrorInvalidToken;
		}
		if ($session->HasScopes($requestedScopes) === false) {
			return self::kAuthErrorRestrictedScope;
		}
		
		$session->Renew();
		static::$session = $session;
		return self::kAuthorized;
	}
	
	protected static function AuthenticateWithDigest(string $cacheKey, string $realm, array $requestedScopes): int {
		$header = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
		$scheme = strtok($header, ' ');
		
		if ($scheme !== self::kAuthSchemeDigest) {
			$nonce = BeaconCommon::GenerateUUID();
			BeaconCache::Set($cacheKey, $nonce, 120);
			return self::kUnauthorized;
		}
		
		$keys = ['nonce', 'nc', 'cnonce', 'qop', 'username', 'uri', 'response'];
		preg_match_all('@(' . implode('|', $keys) . ')=(?:([\'"])([^\2]+?)\2|([^\s,]+))@', $header, $matches, PREG_SET_ORDER);
		$values = [];
		foreach ($matches as $match) {
			$values[$match[1]] = $match[3] ? $match[3] : $match[4];
		}
		
		if (BeaconCommon::HasAllKeys($values, ...$keys) === false) {
			return self::kUnauthorized;
		}
		
		$username = $values['username'];
		if (BeaconCommon::IsUUID($username) === false) {
			return self::kUnauthorized;
		}
		
		$uri = $values['uri'];
		$nc = $values['nc'];
		$cnonce = $values['cnonce'];
		$qop = $values['qop'];
		$method = $_SERVER['REQUEST_METHOD'];
		
		$app = Application::Fetch($username);
		if (is_null($app)) {
			return self::kUnauthorized;
		} else if ($app->HasScopes($requestedScopes) === false) {
			return self::kAuthErrorRestrictedScope;
		}
		$clientSecret = $app->Secret();
		
		$nonce = BeaconCache::Get($cacheKey) ?? '';
		$hash1 = md5("{$username}:{$realm}:{$clientSecret}");
		$hash2 = md5("{$method}:{$uri}");
		$validResponse = md5("{$hash1}:{$nonce}:{$nc}:{$cnonce}:{$qop}:{$hash2}");
		
		if ($values['response'] !== $validResponse) {
			echo "invalid response\n";
			return self::kUnauthorized;
		}
		
		BeaconCache::Remove($cacheKey);
		static::$application = $app;
		return self::kAuthorized;
	}
	
	public static function Authorized(string ...$scopes): bool {
		if (is_null(static::$session)) {
			return false;
		}
		if (count($scopes) === 0) {
			throw new Exception('Did not request any scopes to authorize');
		}
		
		return static::$session->HasScopes($scopes);
	}
	
	public static function Session(): ?Session {
		return static::$session;
	}
	
	public static function SetSession(?Session $session): void {
		static::$session = $session;
		if (is_null($session) === false) {
			static::$application = null;
		}
	}
	
	public static function SessionId(): ?string {
		if (is_null(static::$session)) {
			return null;
		}
		
		return static::$session->SessionId();
	}
	
	public static function Application(): ?Application {
		if (is_null(static::$application) === false) {
			return static::$application;
		} else if (is_null(static::$session) === false) {
			static::$application = static::$session->Application();
			return static::$application;
		} else {
			return null;
		}
	}
	
	public static function SetApplication(?Application $app): void {
		static::$application = $app;
	}
	
	public static function ApplicationId(): ?string {
		if (is_null(static::$application) === false) {
			return static::$application->ApplicationId();
		} else if (is_null(static::$session) === false) {
			static::$application = static::$session->Application();
			return static::$application->ApplicationId();
		} else {
			return null;
		}
	}
	
	public static function UserId(): ?string {
		if (is_null(static::$session)) {
			return null;
		}
		
		return static::$session->UserId();
	}
	
	public static function User(): ?User {
		if (is_null(static::$session)) {
			return null;
		}
		
		return static::$session->User();
	}
	
	public static function Url(string $path = '/') {
		if (strlen($path) == 0 || substr($path, 0, 1) != '/') {
			$path = '/' . $path;
		}
		$domain = BeaconCommon::APIDomain();
		return 'https://' . $domain . '/' . static::APIVersion() . $path;
	}
	
	public static function RegisterRoutes(array $routes): void {
		foreach ($routes as $route => $handlers) {
			preg_match_all('/\{((\.\.\.)?[a-zA-Z0-9\-_]+?)\}/', $route, $placeholders);
			
			$routeExpression = str_replace('/', '\\/', $route);
			$match_count = count($placeholders[0]);
			$variables = [];
			for ($idx = 0; $idx < $match_count; $idx++) {
				$original = $placeholders[0][$idx];
				$key = $placeholders[1][$idx];
				if (str_starts_with($key, '...')) {
					$exclude = '\?';
					$key = substr($key, 3);
				} else {
					$exclude = '\/\?';
				}
				$variables[] = $key;
				$pattern = '(?P<' . $key . '>[^' . $exclude . ']+?)';
				$routeExpression = str_replace($original, $pattern, $routeExpression);
			}
			$routeExpression = '/^' . $routeExpression . '$/';
			
			static::$routes[$route] = [
				'expression' => $routeExpression,
				'handlers' => $handlers,
				'variables' => $variables
			];
		}
	}
	
	public static function Deletions(int $min_version = -1, DateTime $since = null): array {
		if ($since === null) {
			$since = new DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = BeaconCommon::MinVersion();
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query("SELECT object_id, game_id, (CASE game_id WHEN 'Ark' THEN ark.table_to_group(from_table) ELSE from_table END) AS from_table, label, tag FROM public.deletions WHERE min_version <= $1 AND action_time > $2", $min_version, $since->format('Y-m-d H:i:sO'));
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = [
				'objectId' => $results->Field('object_id'),
				'game' => $results->Field('game_id'),
				'group' => $results->Field('from_table'),
				'label' => $results->Field('label'),
				'tag' => $results->Field('tag')
			];
			$results->MoveNext();
		}
		return $arr;
	}
	
	public static function HandleRequest(string $root): void {
		$requestRoute = '/' . $_GET['route'];
		
		if (preg_match('/^\/user(\/.+)?$/', $requestRoute)) {
			static::Authorize(self::kAuthSchemeBearer, 'user:read');
			$requestRoute = str_replace('/user', '/users/' . static::UserId(), $requestRoute);
		} else if (preg_match('/^\/session(\/.+)?$/', $requestRoute)) {
			static::Authorize(self::kAuthSchemeBearer, 'common');
			$requestRoute = str_replace('/session', '/sessions/' . static::SessionId(), $requestRoute);
		}
		
		foreach (static::$routes as $route => $routeInfo) {
			$routeExpression = $routeInfo['expression'];
			$handlers = $routeInfo['handlers'];
			$variables = $routeInfo['variables'];
			
			if (preg_match($routeExpression, $requestRoute, $matches) !== 1) {
				continue;
			}
			
			$requestMethod = strtoupper($_SERVER['REQUEST_METHOD']);
			if (isset($handlers[$requestMethod]) === false) {
				static::ManageRateLimit();
				Response::NewJsonError('Method not allowed', null, 405)->Flush();
				return;
			}
			
			$requiredScopes = ['common'];
			$authScheme = self::kAuthSchemeBearer;
			
			$handler = $handlers[$requestMethod];
			if (is_string($handler)) {
				$handlerFile = $root . '/' . $handler . '.php';
				if (file_exists($handlerFile) === false) {
					static::ManageRateLimit();
					Response::NewJsonError('Endpoint not found', null, 404)->Flush();
					return;
				}
				$handler = 'handleRequest';
				try {
					http_response_code(500); // Set a default. If there is a fatal error, it'll still be set.
					require($handlerFile);
				} catch (Throwable $err) {
					static::ManageRateLimit();
					Response::NewJsonError((BeaconCommon::InProduction() ? 'Error loading api source file.' : $err->getMessage()), null, 500)->Flush();
					return;
				}
			} else if (is_callable($handler) === true) {
				// nothing to do
			} else {
				static::ManageRateLimit();
				Response::NewJsonError('Endpoint not found', null, 404)->Flush();
				return;
			}
			
			static::Authorize($authScheme, ...$requiredScopes);
			static::ManageRateLimit(false); // Check the limit, but don't increment yet
			
			$routeKey = $requestMethod . ' ' . $route;
			$pathParameters = [];
			foreach ($variables as $variableName) {
				$pathParameters[$variableName] = $matches[$variableName];
			}
			
			// include path_parameters and route_key for older implementations
			$context = [
				'pathParameters' => $pathParameters,
				'routeKey' => $routeKey
			];
			try {
				$response = $handler($context);
				static::ManageRateLimit();
				$response->Flush();
			} catch (Exception $err) {
				static::ManageRateLimit();
				Response::NewJsonError((BeaconCommon::InProduction() ? 'Internal server error' : $err->getMessage()), null, 500)->Flush();
				exit;
			}
			return;
		}
		
		static::ManageRateLimit();
		Response::NewJsonError('Endpoint not found: Route not registered.', null, 404)->Flush();
	}
	
	protected static function ManageRateLimit(bool $incrementUsage = true): void {
		$session = static::Session();
		$app = static::Application();
		if (is_null($session) === false) {
			$rateLimitIdentifier = $session->UserId();
		} else {
			$rateLimitIdentifier = BeaconCommon::RemoteAddr(false);
		}
		if (is_null($app) === false) {
			$rateLimitIdentifier .= ':' . $app->ApplicationId();
			$rateLimitCeiling = $app->RequestLimitPerMinute();
		} else {
			$rateLimitCeiling = 30;
		}
		
		$rateLimitUsage = BeaconRateLimits::GetUsage($rateLimitIdentifier, $incrementUsage);
		$rateLimitRemaining = max($rateLimitCeiling - $rateLimitUsage, 0);
		$exceeded = $rateLimitUsage > $rateLimitCeiling;
		
		if ($incrementUsage || $exceeded) {
			header('X-RateLimit-Limit: ' . $rateLimitCeiling);
			header('X-RateLimit-Remaining: ' . $rateLimitRemaining);
			header('X-RateLimit-Reset: 60');
			if (BeaconCommon::InProduction() === false) {
				header('X-RateLimit-Id: ' . $rateLimitIdentifier);
			}
		}
		
		if ($exceeded) {
			header('Retry-After: 10');
			Response::NewJsonError('Rate limit exceeded', null, 429)->Flush();
			exit;
		}
	}
}

?>

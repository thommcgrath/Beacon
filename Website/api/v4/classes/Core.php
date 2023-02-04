<?php

namespace BeaconAPI\v4;
use DateTime, BeaconCommon, BeaconLogin, Exception, Throwable;

class Core {
	protected static $session = null;
	protected static $payload = null;
	protected static $body_raw = null;
	protected static $routes = [];
	
	const kAuthorized = 1;
	const kAuthErrorNoToken = 2;
	const kAuthErrorMalformedToken = 3;
	const kAuthErrorInvalidToken = 4;
	const kAuthErrorRestrictedScope = 5;
	
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
			APIResponse::NewNoContent()->Flush();
		} else {
			APIResponse::NewJSON($payload, $code)->Flush();
		}
		exit;
	}
	
	// deprecated
	public static function ReplyError(string $message, mixed $payload = null, int $code) {
		APIResponse::NewJSONError($message, $payload, $code)->Flush();
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
	
	public static function Authorize(string ...$requiredScopes): void {
		if (count($requiredScopes) === 0) {
			throw new Exception('Did not request any scopes to authorize');
		}
		
		if (is_null(static::$session)) {
			$token = '';
			if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
				$header = $_SERVER['HTTP_AUTHORIZATION'];
				$scheme = strtok($header, ' ');
				if ($scheme === 'Bearer') {
					$token = strtok(' ');
				}
			} else if (isset($_SERVER['HTTP_X_BEACON_TOKEN'])) {
				$token = $_SERVER['HTTP_X_BEACON_TOKEN'];
			}
			
			$authStatus = static::ConsumeToken($token, $requiredScopes);
		} else {
			$authStatus = static::$session->HasScopes($requiredScopes) ? self::kAuthorized : self::kAuthErrorRestrictedScope;
		}
		if ($authStatus === self::kAuthorized) {
			return;
		}
		
		$httpStatus = 401;
		$params = ['Bearer', 'realm="Beacon API"'];
		switch ($authStatus) {
		case self::kAuthErrorNoToken:
			break;
		case self::kAuthErrorMalformedToken:
		case self::kAuthErrorInvalidToken:
			$params[] = 'error="invalid_token"';
			$params[] = 'error_description="The access token is invalid, expired, or malformed."';
			break;
		case self::kAuthErrorRestrictedScope:
			$params[] = 'error="insufficient_scope"';
			$params[] = 'error_description="The access token is valid but does not include the required scopes."';
			$params[] = 'scope="' . implode(' ', $requiredScopes) . '"';
			$httpStatus = 403;
			break;
		}
		
		header('WWW-Authenticate: ' . implode(' ', $params));
		static::ReplyError('Unauthorized', null, 401);
	}
	
	protected static function ConsumeToken(string $token, array $requiredScopes): int {
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
		if ($session->HasScopes($requiredScopes) === false) {
			return self::kAuthErrorRestrictedScope;
		}
		
		$session->Renew();
		static::$session = $session;
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
	
	public static function SessionId(): ?string {
		if (is_null(static::$session)) {
			return null;
		}
		
		return static::$session->SessionId();
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
			static::Authorize('user:read');
			$requestRoute = str_replace('/user', '/users/' . static::UserId(), $requestRoute);
		} else if (preg_match('/^\/session(\/.+)?$/', $requestRoute)) {
			static::Authorize('common');
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
				static::ReplyError('Method not allowed', null, 405);
			}
			
			$handler = $handlers[$requestMethod];
			if (is_string($handler)) {
				$handlerFile = $root . '/' . $handler . '.php';
				if (file_exists($handlerFile) === false) {
					static::ReplyError('Endpoint not found', null, 404);
				}
				$handler = 'handleRequest';
				try {
					http_response_code(500); // Set a default. If there is a fatal error, it'll still be set.
					require($handlerFile);
				} catch (Throwable $err) {
					static::ReplyError((BeaconCommon::InProduction() ? 'Error loading api source file.' : $err->getMessage()), null, 500);
				}
			} else if (is_callable($handler) === true) {
				// nothing to do
			} else {
				static::ReplyError('Endpoint not found', null, 404);
			}
			
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
			$response = $handler($context);
			$response->Flush();
			return;
		}
		static::ReplyError('Endpoint not found: Route not registered.', null, 404);
	}
}

?>

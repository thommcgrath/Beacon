<?php

abstract class BeaconAPI extends \BeaconAPI\Core {
	public static function APIVersionNumber(): int {
		return 4;
	}
	
	public static function UsesLegacyEncryption(): bool {
		return false;
	}
	
	public static function Deletions(int $min_version = -1, \DateTime $since = null) {
		if ($since === null) {
			$since = new \DateTime('2000-01-01');
		}
		
		if ($min_version == -1) {
			$min_version = \BeaconCommon::MinVersion();
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT object_id, game_id, from_table, label, tag FROM public.deletions WHERE min_version <= $1 AND action_time > $2;', $min_version, $since->format('Y-m-d H:i:sO'));
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = [
				'object_id' => $results->Field('object_id'),
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
		$request_route = '/' . $_GET['route'];
		
		if (preg_match('/^\/user$/', $request_route) || preg_match('/^\/user\//', $request_route)) {
			static::Authorize();
			$request_route = str_replace('/user', '/users/' . static::UserID(), $request_route);
		}
		
		foreach (static::$routes as $route => $route_info) {
			$route_expression = $route_info['expression'];
			$handlers = $route_info['handlers'];
			$variables = $route_info['variables'];
			
			if (preg_match($route_expression, $request_route, $matches) !== 1) {
				continue;
			}
			
			$request_method = strtoupper($_SERVER['REQUEST_METHOD']);
			if ($request_method === 'PUT') {
				$request_method = 'POST';
			}
			if (isset($handlers[$request_method]) === false) {
				static::ReplyError('Method not allowed', null, 405);
			}
			
			$handler = $handlers[$request_method];
			if (is_string($handler)) {
				$handler_file = $root . '/' . $handler . '.php';
				if (file_exists($handler_file) === false) {
					static::ReplyError('Endpoint not found', null, 404);
				}
				$handler = 'handle_request';
				try {
					http_response_code(500); // Set a default. If there is a fatal error, it'll still be set.
					require($handler_file);
				} catch (\Throwable $err) {
					static::ReplyError('Error loading api source file.', null, 500);
				}
			} else if (is_callable($handler) === true) {
				// nothing to do
			} else {
				static::ReplyError('Endpoint not found', null, 404);
			}
			
			$route_key = $request_method . ' ' . $route;
			$path_parameters = [];
			foreach ($variables as $variable_name) {
				$path_parameters[$variable_name] = $matches[$variable_name];
			}
			
			$context = [
				'path_parameters' => $path_parameters,
				'route_key' => $route_key
			];
			$handler($context);
			return;
		}
		static::ReplyError('Endpoint not found: Route not registered.', null, 404);
	}
}

?>

<?php

abstract class BeaconErrors {
	private static $handlers = [];
	private static $secure_mode = true;
	
	public static function SecureMode(): bool {
		return static::$secure_mode;
	}
	
	public static function SetSecureMode(bool $secure_mode): void {
		static::$secure_mode = $secure_mode;
	}
	
	public static function AddHandler(callable $handler): void {
		array_unshift(static::$handlers, $handler);
	}
	
	public static function RemoveLastHandler(): void {
		array_shift(static::$handlers);
	}
	
	public static function StartWatching(): void {
		ini_set('display_errors', '1');
		error_reporting(E_ALL);
		set_exception_handler(['BeaconErrors', 'HandleException']);
		set_error_handler(['BeaconErrors', 'HandleError'], E_ALL);
	}
	
	public static function HandleException(Throwable $err): void {
		static::LogTrace(get_class($err), html_entity_decode($err->getMessage(), ENT_COMPAT, 'UTF-8'), $err->getFile(), $err->getLine());
	}
	
	public static function HandleError(int $errno, string $errstr, string $errfile, int $errline): bool {
		if ((error_reporting() & $errno) !== $errno) {
			return true;
		}
		
		if (static::$secure_mode) {
			switch ($errno) {
			case E_NOTICE:
			case E_WARNING:
			case E_DEPRECATED:
			case E_USER_NOTICE:
			case E_USER_WARNING:
			case E_USER_DEPRECATED:
				// In production, we don't want to react to these errors.
				return true;
			}
		}
		
		static::LogTrace('Error', html_entity_decode($errstr, ENT_COMPAT, 'UTF-8'), $errfile, $errline);
		
		return true;
	}
	
	protected static function LogTrace(string $type, string $message, string $file, int $line): void {
		// explain it
		$description = 'Unhandled ' . $type . ' in ' . $file . ' at line ' . $line . ': ' . $message;
		
		// collect the stack and remove the noise
		$ignore_methods = ['HandleException', 'HandleError', 'LogTrace', 'trigger_error'];
		$stack = debug_backtrace();
		while ((count($stack) > 0) && (in_array($stack[0]['function'], $ignore_methods))) {
			array_shift($stack);
		}
		
		// assemble the trace
		$trace = [];
		foreach ($stack as $frame) {
			$values = [];
			if (array_key_exists('args', $frame)) {
				foreach ($frame['args'] as $arg) {
					$values[] = var_export($arg, true);
				}
			}
			
			$fn = $frame['function'] . '(' . implode(', ', $values) . ')';
			if (array_key_exists('file', $frame) && array_key_exists('line', $frame)) {
				$trace[] = $frame['file'] . '(' . $frame['line'] . '): ' . $fn;
			} else {
				$trace[] = $fn;
			}
		}
		
		// notify
		if (static::$secure_mode) {
			$attachments = [
				[
					'title' => 'Stack Details',
					'fields' => [
						[
							'title' => 'Trace',
							'value' => implode("\n", $trace)
						],
						[
							'title' => 'Request Method',
							'value' => $_SERVER['REQUEST_METHOD'],
							'short' => true
						],
						[
							'title' => 'Request URI',
							'value' => $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'],
						],
						[
							'title' => 'GET',
							'value' => isset($_GET) ? var_export($_GET, true) : 'null'
						],
						[
							'title' => 'POST',
							'value' => isset($_POST) ? var_export($_POST, true) : 'null'
						],
						[
							'title' => 'SESSION',
							'value' => isset($_SESSION) ? var_export($_SESSION, true) : 'null'
						],
						[
							'title' => 'COOKIE',
							'value' => isset($_COOKIE) ? var_export($_COOKIE, true) : 'null'
						]
					],
					'ts' => time()
				]
			];
			BeaconCommon::PostSlackRaw(json_encode(['text' => $description, 'attachments' => $attachments]));
		}
		
		// pass to handlers
		$handled = false;
		foreach (static::$handlers as $handler) {
			if (is_callable($handler)) {
				$handled = $handler($description, $trace) === true;
				if ($handled) {
					break;
				}
			}
		}
		
		// if not handled, then do it ourselves
		if (!$handled) {
			if (static::$secure_mode) {
				echo 'There was an unexpected error.';
			} else {
				switch (BeaconCommon::CurrentContentType()) {
				case 'text/html':
					echo '<h1>Unhandled Error</h1>';
					echo '<p>' . nl2br(htmlentities($description)) . '</p>';
					if (count($trace) > 0) {
						echo '<h3>Stack Trace</h3>';
						echo '<ol>';
						foreach ($trace as $line) {
							echo '<li>' . nl2br(htmlentities(var_export($line, true))) . '</li>';
						}
						echo '</ol>';
					}
					break;
				case 'application/json':
					echo json_encode(['description' => $description, 'trace' => $trace], JSON_PRETTY_PRINT);
					break;
				default:
					echo $description . "\n\n" . implode("\n", $trace);
					break;
				}
			}
		}
		
		// end the script
		http_response_code(500);
		exit;
	}
}

?>
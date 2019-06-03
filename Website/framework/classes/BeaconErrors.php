<?php

abstract class BeaconErrors {
	private static $handlers = array();
	private static $secure_mode = true;
	
	public static function SecureMode() {
		return static::$secure_mode;
	}
	
	public static function SetSecureMode(bool $secure_mode) {
		static::$secure_mode = $secure_mode;
	}
	
	public static function AddHandler(callable $handler) {
		array_unshift(static::$handlers, $handler);
	}
	
	public static function RemoveLastHandler() {
		array_shift(static::$handlers);
	}
	
	public static function StartWatching() {
		ini_set('display_errors', '1');
		error_reporting(E_ALL);
		set_exception_handler(array('BeaconErrors', 'HandleException'));
		set_error_handler(array('BeaconErrors', 'HandleError'), E_ALL);
	}
	
	public static function HandleException(Throwable $err) {
		static::LogTrace(get_class($err), html_entity_decode($err->getMessage(), ENT_COMPAT, 'UTF-8'), $err->getFile(), $err->getLine());
	}
	
	public static function HandleError(int $errno, string $errstr, string $errfile, int $errline) {
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
	
	protected static function LogTrace(string $type, string $message, string $file, int $line) {
		// explain it
		$description = 'Unhandled ' . $type . ' in ' . $file . ' at line ' . $line . ': ' . $message;
		
		// collect the stack and remove the noise
		$ignore_methods = array('HandleException', 'HandleError', 'LogTrace', 'trigger_error');
		$stack = debug_backtrace();
		while ((count($stack) > 0) && (in_array($stack[0]['function'], $ignore_methods))) {
			array_shift($stack);
		}
		
		// assemble the trace
		$trace = array();
		foreach ($stack as $frame) {
			$values = array();
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
			$attachments = array(
				array(
					'title' => 'Stack Details',
					'fields' => array(
						array(
							'title' => 'Trace',
							'value' => implode("\n", $trace)
						),
						array(
							'title' => 'Request Method',
							'value' => $_SERVER['REQUEST_METHOD'],
							'short' => true
						),
						array(
							'title' => 'Request URI',
							'value' => $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'],
						),
						array(
							'title' => 'GET',
							'value' => var_export($_GET, true)
						),
						array(
							'title' => 'POST',
							'value' => var_export($_POST, true)
						),
						array(
							'title' => 'SESSION',
							'value' => var_export($_SESSION, true)
						),
						array(
							'title' => 'COOKIE',
							'value' => var_export($_COOKIE, true)
						)
					),
					'ts' => time()
				)
			);
			BeaconCommon::PostSlackRaw(json_encode(array('text' => $description, 'attachments' => $attachments)));
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
					echo json_encode(array('description' => $description, 'trace' => $trace), JSON_PRETTY_PRINT);
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
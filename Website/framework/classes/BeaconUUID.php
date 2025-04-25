<?php

abstract class BeaconUUID {
	public static function v4(): string {
		$data = random_bytes(16);
		$data[6] = chr(ord($data[6]) & 0x0f | 0x40); // set version to 0100
		$data[8] = chr(ord($data[8]) & 0x3f | 0x80); // set bits 6-7 to 10
		return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
	}

	public static function v5(string $name, string $namespace = '82aa4465-85f9-4b9e-8d36-f66164cef0a6'): string {
		if (static::Validate($namespace) === false) {
			throw new Exception('Names should be a UUID.');
		}

		$hex = str_replace('-', '', $namespace);
		$namespaceBits = hex2bin($hex);

		$hash = sha1($namespaceBits . $name);
		return sprintf('%08s-%04s-%04x-%04x-%12s', substr($hash, 0, 8), substr($hash, 8, 4), (hexdec(substr($hash, 12, 4)) & 0x0fff) | 0x5000, (hexdec(substr($hash, 16, 4)) & 0x3fff) | 0x8000, substr($hash, 20, 12));
	}

	public static function v7(?float $time = null): string {
		if (is_null($time)) {
			$time = microtime(true) * 1000;
		}

		$time = floor($time);
		$bytes = random_bytes(16);
		$bytes[0] = chr(($time >> 40) & 0xFF);
		$bytes[1] = chr(($time >> 32) & 0xFF);
		$bytes[2] = chr(($time >> 24) & 0xFF);
		$bytes[3] = chr(($time >> 16) & 0xFF);
		$bytes[4] = chr(($time >> 8) & 0xFF);
		$bytes[5] = chr($time & 0xFF);
		$bytes[6] = chr((ord($bytes[6]) & 15) | 112);
		$bytes[8] = chr((ord($bytes[8]) & 63) | 128);
		return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($bytes), 4));
	}

	public static function Validate(&$input): bool {
		if (!is_string($input)) {
			return false;
		}

		$cleaned = preg_replace('/\s+/', '', $input);
		if ($cleaned === '00000000-0000-0000-0000-000000000000') {
			return true;
		}

		if (preg_match('/^([0-9A-F]{8})-?([0-9A-F]{4})-?([0-9A-F]{4})-?([0-9A-F]{4})-?([0-9A-F]{12})$/i', $cleaned, $matches) === 1) {
			$input = strtolower($matches[1] . '-' . $matches[2] . '-' . $matches[3] . '-' . $matches[4] . '-' . $matches[5]);
			return true;
		} else {
			return false;
		}
	}
}

?>

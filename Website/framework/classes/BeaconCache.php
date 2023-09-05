<?php

abstract class BeaconCache {
	protected static $mem = null;
	
	protected static function Init(): void {
		if (is_null(static::$mem)) {
			static::$mem  = new Memcached();
			static::$mem->addServer('127.0.0.1', 11211);
		}
	}
	
	public static function Get(string $key): mixed {
		static::Init();
		$key = BeaconCommon::Domain() . ':' . $key;
		$value = static::$mem->get($key);
		$status = static::$mem->getResultCode();
		if ($status == 0) {
			return $value;
		} elseif ($status == 16) {
			return null;
		} else {
			throw new Exception('Memcached Error: ' . $status);
		}
	}
	
	public static function Set(string $key, mixed $value, int $ttl = 0): void {
		static::Init();
		$key = BeaconCommon::Domain() . ':' . $key;
		static::$mem->set($key, $value, $ttl);
		$status = static::$mem->getResultCode();
		if ($status != 0) {
			throw new Exception('Memcached Error: ' . $status);
		}
	}
	
	public static function Remove(string $key): void {
		static::Init();
		$key = BeaconCommon::Domain() . ':' . $key;
		static::$mem->delete($key, 0);
		$status = static::$mem->getResultCode();
		if ($status != 0) {
			throw new Exception('Memcached Error: ' . $status);
		}
	}
}

?>
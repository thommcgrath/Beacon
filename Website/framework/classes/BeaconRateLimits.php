<?php

abstract class BeaconRateLimits {
	// Returns the usage, increments if $incrementUsage is true
	public static function GetUsage(string $identifier, bool $incrementUsage = false): int {
		$rateLimitKey = static::PrepareKey($identifier);
		$rateLimitHistory = BeaconCache::Get($rateLimitKey);
		if (is_null($rateLimitHistory)) {
			$rateLimitHistory = [];
		}
		$arrayKey = intval(date('YmdHis'));
		$oldestKey = intval(date('YmdHis', time() - 60));
		if ($incrementUsage) {
			$amount = $rateLimitHistory[$arrayKey] ?? 0;
			$amount++;
			$rateLimitHistory[$arrayKey] = $amount;
		}
		$rateLimitHistory = array_filter($rateLimitHistory, function ($key) use ($oldestKey) { return $key > $oldestKey; }, ARRAY_FILTER_USE_KEY);
		BeaconCache::Set($rateLimitKey, $rateLimitHistory, 120);
		return array_sum($rateLimitHistory);
	}
	
	// Convenience function for calling GetUsage with $incrementUsage
	public static function IncrementUsage(string $identifier): int {
		return static::GetUsage($identifier, true);
	}
	
	protected static function PrepareKey(string $identifier): string {
		return hash('sha1', 'RateLimits:' . $identifier);
	}
}

?>

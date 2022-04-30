<?php

abstract class BeaconUpdates {
	const CHANNEL_ALPHA = 1;
	const CHANNEL_BETA = 2;
	const CHANNEL_STABLE = 3;
	
	const ARCH_INTEL32 = 1;
	const ARCH_INTEL64 = 2;
	const ARCH_ARM64 = 4;
	const ARCH_ARM32 = 8;
	const ARCH_INTEL = self::ARCH_INTEL32 | self::ARCH_INTEL64;
	const ARCH_ARM = self::ARCH_ARM32 | self::ARCH_ARM64;
	const ARCH_32 = self::ARCH_INTEL32 | self::ARCH_ARM32;
	const ARCH_64 = self::ARCH_INTEL64 | self::ARCH_INTEL64;
		
	const SIGNATURE_RSA = 'RSA';
	const SIGNATURE_DSA = 'DSA';
	const SIGNATURE_ED25519 = 'ed25519';
	
	const PLATFORM_MACOS = 'macOS';
	const PLATFORM_WINDOWS = 'Windows';
	const PLATFORM_LINUX = 'Linux';
	
	public static function FindUpdates(int $current_build, int $device_mask, int $channel, string|null $device_os = null): array {
		$database = BeaconCommon::Database();
		$updates = [];
		$values = [$channel, $current_build];
		$sql = 'SELECT update_id, build_number, build_display, stage, preview, notes, min_mac_version, min_win_version, EXTRACT(epoch FROM published) AS release_date, delta_version, CASE WHEN UPPER_INC(lock_versions) THEN UPPER(lock_versions) ELSE UPPER(lock_versions) - 1 END AS critical_version FROM updates WHERE stage >= $1 AND build_number > $2';
		if (is_null($device_os) === false) {
			list($device_platform, $osversion) = explode(' ', $device_os, 2);
			switch ($device_platform) {
			case self::PLATFORM_MACOS:
				$sql .= ' AND os_version_as_integer(min_mac_version) <= os_version_as_integer($3)';
				$values[] = $osversion;
				break;
			case self::PLATFORM_WINDOWS:
				$sql .= ' AND os_version_as_integer(min_win_version) <= os_version_as_integer($3)';
				$values[] = $osversion;
				break;
			}
		}
		$sql .= ' ORDER BY build_number DESC';
		if ($current_build <= 0) {
			$sql .= ' LIMIT 10';
		}
		$sql .= ';';
		
		$rows = $database->Query($sql, $values);
		while ($rows->EOF() === false) {
			$update_id = $rows->Field('update_id');
			$downloads = $database->Query('SELECT download_urls.url, download_urls.platform, download_signatures.format, download_signatures.signature, download_urls.architectures FROM download_urls INNER JOIN download_signatures ON (download_signatures.download_id = download_urls.download_id) WHERE download_urls.update_id = $1', $update_id);
			$scores = [];
			$best_downloads = [];
			while ($downloads->EOF() === false) {
				$url = $downloads->Field('url');
				$platform = $downloads->Field('platform');
				$signature = $downloads->Field('signature');
				$download_mask = $downloads->Field('architectures');
				$format = $downloads->Field('format');
				
				if (static::IsCompatible($platform, $device_mask, $download_mask) === false) {
					$downloads->MoveNext();
					continue;
				}
				
				$num_architectures = count(static::ArchitecturesInMask($download_mask));
				if (array_key_exists($platform, $scores)) {
					$lowest_score = $scores[$platform];
				} else {
					$lowest_score = 999;
				}
				if ($num_architectures <= $lowest_score) {
					$scores[$platform] = $num_architectures;
					$platform_downloads = [];
					if (array_key_exists($platform, $best_downloads)) {
						$platform_downloads = $best_downloads[$platform];
					}
					$signatures = [];
					if (array_key_exists($url, $platform_downloads)) {
						$signatures = $platform_downloads[$url];
					}
					$signatures[$format] = $signature;
					$best_downloads[$platform] = [$url => $signatures]; // Reset the array to not hold onto urls we shouldn't have
				}
				
				$downloads->MoveNext();
			}
			
			if (count($best_downloads) > 0) {
				$updates[] = [
					'update_id' => $rows->Field('update_id'),
					'build_number' => $rows->Field('build_number'),
					'build_display' => $rows->Field('build_display'),
					'stage' => $rows->Field('stage'),
					'preview' => $rows->Field('preview'),
					'notes' => $rows->Field('notes'),
					'min_mac_version' => $rows->Field('min_mac_version'),
					'min_win_version' => $rows->Field('min_win_version'),
					'publish_time' => $rows->Field('release_date'),
					'delta_version' => $rows->Field('delta_version'),
					'required_if_below' => $rows->Field('critical_version'),
					'files' => $best_downloads
				];
			}
			
			$rows->MoveNext();
		}
		return $updates;
	}
	
	public static function FindLatestInChannel(int $channel): array {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT update_id, build_number, build_display, stage, preview, notes, min_mac_version, min_win_version, EXTRACT(epoch FROM published) AS release_date, delta_version FROM updates WHERE stage >= $1 ORDER BY build_number DESC LIMIT 1;', $channel);
		$updates = null;
		if ($rows->RecordCount() === 0) {
			return $updates;
		}
		
		$update_id = $rows->Field('update_id');
		$files = [];
		$downloads = $database->Query('SELECT DISTINCT url, platform, architectures FROM download_urls WHERE update_id = $1;', $update_id);
		while ($downloads->EOF() === false) {
			$platform = $downloads->Field('platform');
			$url = $downloads->Field('url');
			$architectures = $downloads->Field('architectures');
			
			$platform_array = [];
			if (array_key_exists($platform, $files)) {
				$platform_array = $files[$platform];
			}
			$platform_array[$url] = $architectures;
			$files[$platform] = $platform_array;
			
			$downloads->MoveNext();
		}
		
		$update = [
			'update_id' => $update_id,
			'build_number' => $rows->Field('build_number'),
			'build_display' => $rows->Field('build_display'),
			'stage' => $rows->Field('stage'),
			'preview' => $rows->Field('preview'),
			'notes' => $rows->Field('notes'),
			'min_mac_version' => $rows->Field('min_mac_version'),
			'min_win_version' => $rows->Field('min_win_version'),
			'publish_time' => $rows->Field('release_date'),
			'delta_version' => $rows->Field('delta_version'),
			'files' => $files
		];
		
		return $update;
	}
	
	protected static function ArchitecturesInMask(int $mask): array {
		$architectures = [];
		if (($mask & self::ARCH_INTEL32) === self::ARCH_INTEL32) {
			$architectures[] = self::ARCH_INTEL32;
		}
		if (($mask & self::ARCH_INTEL64) === self::ARCH_INTEL64) {
			$architectures[] = self::ARCH_INTEL64;
		}
		if (($mask & self::ARCH_ARM64) === self::ARCH_ARM64) {
			$architectures[] = self::ARCH_ARM64;
		}
		if (($mask & self::ARCH_ARM32) === self::ARCH_ARM32) {
			$architectures[] = self::ARCH_ARM32;
		}
		return $architectures;
	}
	
	protected static function IsCompatible(string $platform, int $device_mask, int $download_mask): bool {
		if (($download_mask & $device_mask) === $device_mask) {
			// Native
			return true;
		}
		
		// This gets more complicated
		if ($platform === 'macOS') {
			// Thanks to Rosetta, ARM Macs can run Intel binaries
			if ($device_mask === self::ARCH_ARM64 && (($download_mask & self::ARCH_INTEL64) === self::ARCH_INTEL64)) {
				return true;
			}
		}
		
		// Windows support for running Intel binaries on ARM is coming, but not consistent enough yet, so we'll say no for now
		return false;
	}
}

?>

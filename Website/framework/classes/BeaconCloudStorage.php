<?php

abstract class BeaconCloudStorage {
	const FILE_NOT_FOUND = 404;
	const FAILED_TO_WARM_CACHE = 500;
	const STORAGE_LIMIT = 2147483648;

	private static function CleanupRemotePath(string $remote_path): string {
		if (substr($remote_path, 0, 1) != '/') {
			$remote_path = '/' . $remote_path;
		}
		return $remote_path;
	}

	private static function LocalPath(string $remote_path, ?string $version_id = null): string {
		$local_path = '/srv/beacon-usercloud' . static::CleanupRemotePath($remote_path);
		if (is_null($version_id) === false) {
			$local_path .= '-' . $version_id;
		}
		return $local_path;
	}

	private static function CleanupLocalCache(int $required_bytes): void {
		$hostname = gethostname();
		$database = BeaconCommon::Database();
		$target_bytes = max(static::STORAGE_LIMIT - $required_bytes, 0);

		$database->BeginTransaction();
		$results = $database->Query('SELECT cache_id, remote_path FROM usercloud_cache WHERE last_accessed < CURRENT_TIMESTAMP - \'2 days\'::INTERVAL AND remote_path NOT IN (SELECT remote_path FROM usercloud_queue);');
		while (!$results->EOF()) {
			$remote_path = $results->Field('remote_path');
			$cache_id = $results->Field('cache_id');
			$local_path = static::LocalPath($remote_path);

			if (file_exists($local_path)) {
				static::DeleteLocalPath($local_path);
				$database->Query('DELETE FROM usercloud_cache WHERE cache_id = $1;', $cache_id);
			}

			$results->MoveNext();
		}

		$results = $database->Query('SELECT SUM(size_in_bytes) AS consumed_bytes FROM usercloud_cache WHERE hostname = $1;', $hostname);
		$consumed_bytes = $results->Field('consumed_bytes');
		if ($consumed_bytes < $target_bytes) {
			$database->Commit();
			return;
		}

		$results = $database->Query('SELECT usercloud.remote_path, usercloud_cache.size_in_bytes, usercloud_cache.cache_id FROM usercloud_cache INNER JOIN usercloud ON (usercloud_cache.remote_path = usercloud.remote_path) WHERE usercloud_cache.hostname = $1 AND usercloud_cache.remote_path NOT IN (SELECT remote_path FROM usercloud_queue) ORDER BY last_accessed ASC, size_in_bytes DESC;', $hostname);
		while (!$results->EOF() && $consumed_bytes >= $target_bytes) {
			$cache_id = $results->Field('cache_id');
			$remote_path = $results->Field('remote_path');
			$local_path = static::LocalPath($remote_path);
			$size_in_bytes = $results->Field('size_in_bytes');

			if (file_exists($local_path)) {
				static::DeleteLocalPath($local_path);
				$database->Query('DELETE FROM usercloud_cache WHERE cache_id = $1;', $cache_id);
				$consumed_bytes = max($consumed_bytes - $size_in_bytes, 0);
			}

			$results->MoveNext();
		}
		$database->Commit();
	}

	private static function DeleteLocalPath(string $local_path, bool $is_dir = false, string $root = ''): void {
		if (empty($root)) {
			$root = static::LocalPath('/');
		}

		$parent_path = dirname($local_path);
		if ($is_dir) {
			rmdir($local_path);
		} else {
			unlink($local_path);
		}
		if (substr($parent_path, 0, strlen($root)) !== $root) {
			return;
		}

		// if the parent is not empty, this block will end the function early
		$handle = opendir($parent_path);
		while (($entry = readdir($handle)) !== false) {
			if ($entry == '.' || $entry == '..') {
				continue;
			}
			closedir($handle);
			return;
		}

		static::DeleteLocalPath($parent_path, true, $root);
	}

	private static function MimeForPath(string $local_path): string {
		$extension = strtolower(pathinfo($local_path, PATHINFO_EXTENSION));

		switch ($extension) {
		case 'beacon':
		case 'beaconpreset':
		case 'beacontemplate':
		case 'beaconidentity':
		case 'txt':
		case 'json':
			return 'text/plain';
		case 'png':
			return 'image/png';
		case 'jpg':
		case 'jpeg':
			return 'image/jpeg';
		case 'gif':
			return 'image/gif';
		default:
			return 'application/octet-stream';
		}
	}

	private static function BuildSignedURL(string $bucket_path, string $remote_path, string $method): string {
		$resource_path = static::CleanupRemotePath($remote_path);
		$bucket_name = substr($bucket_path, strpos($bucket_path, '/'));
		$signing_path = "$bucket_name$resource_path";
		$pos = strpos($signing_path, '?');
		if ($pos !== false) {
			$query = substr($signing_path, $pos + 1);
			$signing_path = substr($signing_path, 0, $pos);
			$params = [];
			parse_str($query, $params);
			$subresource = [];
			foreach ($params as $key => $value) {
				switch ($key) {
				case 'versions':
				case 'acl':
				case 'location':
				case 'logging':
				case 'torrent':
				case 'versionId':
					if (empty($value)) {
						$subresource[] = urlencode($key);
					} else {
						$subresource[] = urlencode($key) . '=' . urlencode($value);
					}
					break;
				}
			}
			if (count($subresource) > 0) {
				$signing_path .= '?' . implode('&', $subresource);
			}
		}

		$expiration = time() + 60;
		$str_to_sign = implode("\n", [$method, '', '', $expiration, $signing_path]);
		$signature = base64_encode(hash_hmac('sha1', $str_to_sign, BeaconCommon::GetGlobal('Storage_Password'), true));
		return 'https://' . $bucket_path . $resource_path . (strpos($resource_path, '?') === false ? '?' : '&') . 'AWSAccessKeyId=' . urlencode(BeaconCommon::GetGlobal('Storage_Username')) . '&Expires=' . urlencode($expiration) . '&Signature=' . urlencode($signature);
	}

	private static function WarmFile(string $remotePath, ?string $versionId): int|string {
		$remotePath = static::CleanupRemotePath($remotePath);
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT bucket, hash, size_in_bytes FROM usercloud WHERE remote_path = $1;', $remotePath);
		if ($results->RecordCount() == 0) {
			return static::FILE_NOT_FOUND;
		}
		$bucketPath = $results->Field('bucket');
		$localPath = static::LocalPath($remotePath, $versionId);
		if (is_null($versionId) === false) {
			$remotePath .= '?versionId=' . urlencode($versionId);
		}
		$fileId = crc32($remotePath);
		$database->BeginTransaction();
		$database->Query('SELECT pg_advisory_xact_lock($1);', $fileId);
		$localExists = file_exists($localPath);
		$correctHash = $results->Field('hash');
		$correctFilesize = $results->Field('size_in_bytes');
		$hostname = gethostname();
		$results = $database->Query('SELECT cache_id, hash, size_in_bytes FROM usercloud_cache WHERE remote_path = $1 AND hostname = $2;', $remotePath, $hostname);
		$isCached = false;
		$cacheId = null;
		if ($results->RecordCount() == 1) {
			$cacheId = $results->Field('cache_id');
			$cachedHash = $results->Field('hash');
			$cachedSize = $results->Field('size_in_bytes');
			if ($cachedHash === $correctHash && $cachedSize === $correctFilesize) {
				$isCached = true;
			}
		}

		if ($localExists === false || $isCached === false) {
			static::CleanupLocalCache($correctFilesize);

			$parent = dirname($localPath);
			static::SetupDir($parent);

			$session = null;
			$remoteHandle = null;

			// See if the file in question is pending uploaded somewhere else
			$results = $database->Query('SELECT hostname FROM usercloud_queue WHERE remote_path = $1 AND request_method = $2 AND hostname != $3;', $remotePath, 'PUT', $hostname);
			if ($results->RecordCount() > 0) {
				$session = ssh2_connect($results->Field('hostname'), 22);
				if ($session === false) {
					return static::FAILED_TO_WARM_CACHE;
				}
				$keyfile = BeaconCommon::FrameworkPath() . '/keys/cacheshare';
				ssh2_auth_pubkey_file($session, 'cacheshare', $keyfile . '.pub', $keyfile, BeaconCommon::GetGlobal('CacheShare Secret'));
				$remoteHandle = @fopen("ssh2.sftp://$session/beacon-usercloud$remotePath", 'rb');
				if (empty($remoteHandle)) {
					$database->Rollback();
					return static::FAILED_TO_WARM_CACHE;
				}

				$localHandle = fopen($localPath, 'wb');
				while (!feof($remoteHandle)) {
					$chunk = fread($remoteHandle, 1048576);
					fwrite($localHandle, $chunk);
				}
				fclose($localHandle);
				unset($session);
			} else {
				$buckets = static::AllBuckets($bucketPath);
				$fileDownloaded = false;
				foreach ($buckets as $bucket) {
					$url = static::BuildSignedURL($bucket, $remotePath, 'GET');
					$localHandle = fopen($localPath, 'wb');
					$curl = curl_init($url);
					curl_setopt($curl, CURLOPT_FILE, $localHandle);
					curl_exec($curl);
					$httpStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
					curl_close($curl);
					fclose($localHandle);
					if ($httpStatus === 200) {
						$fileDownloaded = true;
						break;
					}
				}
				if (!$fileDownloaded) {
					$database->Rollback();
					return static::FAILED_TO_WARM_CACHE;
				}
			}

			chmod($localPath, 0640);
			chgrp($localPath, 'cacheshare');

			$cachedSize = filesize($localPath);
			$cachedHash = hash_file('sha256', $localPath);

			if (is_null($versionId) === true && ($cachedSize != $correctFilesize || $cachedHash != $correctHash)) {
				static::DeleteLocalPath($localPath);
				if (is_null($cacheId) == false) {
					$database->Query('DELETE FROM usercloud_cache WHERE cache_id = $1;', $cacheId);
				}
				$database->Commit();
				return static::FAILED_TO_WARM_CACHE;
			}
		}

		if (!is_null($cacheId)) {
			$database->Query('UPDATE usercloud_cache SET size_in_bytes = $2, hash = $3, last_accessed = CURRENT_TIMESTAMP WHERE cache_id = $1;', $cacheId, $cachedSize, $cachedHash);
		} else {
			$database->Query('INSERT INTO usercloud_cache (hostname, remote_path, size_in_bytes, hash) VALUES ($1, $2, $3, $4)', $hostname, $remotePath, $cachedSize, $cachedHash);
		}
		$database->Commit();

		return $localPath;
	}

	public static function DetailsForFile(string $remote_path): array|bool {
		$database = BeaconCommon::Database();
		$remote_path = static::CleanupRemotePath($remote_path);
		$results = $database->Query('SELECT remote_path, content_type, size_in_bytes, modified, deleted, header FROM usercloud WHERE remote_path = $1;', $remote_path);
		if ($results->RecordCount() !== 1) {
			return false;
		}

		return [
			'path' => $results->Field('remote_path'),
			'type' => $results->Field('content_type'),
			'size' => intval($results->Field('size_in_bytes')),
			'modified' => $results->Field('modified'),
			'deleted' => $results->Field('deleted'),
			'header' => $results->Field('header')
		];
	}

	public static function RunQueue(): void {
		$hostname = gethostname();
		$database = BeaconCommon::Database();

		$results = $database->Query('SELECT COUNT(attempts) AS objects_delayed FROM usercloud_queue WHERE attempts = 3;');
		$objects_delayed = intval($results->Field('objects_delayed'));

		$database->BeginTransaction();
		$database->Query('UPDATE usercloud_queue SET http_status = NULL WHERE http_status IS NOT NULL AND attempts < 3;');
		$database->Commit();
		while (true) {
			$database->BeginTransaction();
			$results = $database->Query('SELECT usercloud.bucket, usercloud_queue.remote_path, usercloud_queue.request_method, usercloud.content_type FROM usercloud_queue LEFT JOIN usercloud ON (usercloud_queue.remote_path = usercloud.remote_path) WHERE usercloud_queue.hostname = $1 AND usercloud_queue.http_status IS NULL AND usercloud_queue.attempts < 3 ORDER BY usercloud_queue.queue_time ASC LIMIT 1 FOR UPDATE OF usercloud_queue SKIP LOCKED;', $hostname);
			if ($results->RecordCount() == 0) {
				$database->Rollback();
				break;
			}

			$bucket_path = $results->Field('bucket');
			if (is_null($bucket_path)) {
				$database->Query('DELETE FROM usercloud_queue WHERE remote_path = $1 AND request_method = $2 AND hostname = $3;', $results->Field('remote_path'), $results->Field('request_method'), $hostname);
				$database->Commit();
				continue;
			}

			$bucket_name = substr($bucket_path, strpos($bucket_path, '/'));
			$remote_path = $results->Field('remote_path');
			$local_path = static::LocalPath($remote_path);
			$request_method = $results->Field('request_method');
			$content_type = $results->Field('content_type');
			$date = gmdate('Y-m-d\TH:i:s\Z', time());
			$resource_path = static::CleanupRemotePath($remote_path);
			$str_to_sign = implode("\n", [$request_method, '', $content_type, $date, $bucket_name . $resource_path]);
			$signature = base64_encode(hash_hmac('sha1', $str_to_sign, BeaconCommon::GetGlobal('Storage_Password'), true));
			$response = false;

			$curl = curl_init();
			if ($curl === false) {
				$database->Rollback();
				throw new Exception('Unable to get curl handle');
			}

			curl_setopt($curl, CURLOPT_URL, 'https://' . $bucket_path . $resource_path);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_HTTPHEADER, [
					'Authorization: AWS ' . BeaconCommon::GetGlobal('Storage_Username') . ':' . $signature,
					'Date: ' . $date,
					'Content-Type: ' . $content_type
				]
			);
			curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
			switch ($request_method) {
			case 'PUT':
				if (file_exists($local_path) === false) {
					$database->Query('UPDATE usercloud_queue SET http_status = $3, attempts = attempts + 1 WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname, 404);
					$database->Commit();
					usleep(10000);
					break;
				}
				curl_setopt($curl, CURLOPT_PUT, true);
				$reader = fopen($local_path, 'r');
				curl_setopt($curl, CURLOPT_INFILE, $reader);
				curl_setopt($curl, CURLOPT_INFILESIZE, filesize($local_path));
				$response = curl_exec($curl);
				fclose($reader);
				break;
			case 'DELETE':
				curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "DELETE");
				$response = curl_exec($curl);
				break;
			}

			$success = false;
			$http_status = 0;
			if ($response !== false) {
				$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
				$success = $http_status >= 200 && $http_status < 300;
			}

			if ($success) {
				$database->Query('DELETE FROM usercloud_queue WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname);
			} else {
				$database->Query('UPDATE usercloud_queue SET http_status = $3, attempts = attempts + 1 WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname, $http_status);
			}

			$database->Commit();
			curl_close($curl);

			usleep(10000);
		}

		$results = $database->Query('SELECT COUNT(attempts) AS objects_delayed FROM usercloud_queue WHERE attempts = 3;');
		$new_objects_delayed = intval($results->Field('objects_delayed')) - $objects_delayed;
		if ($new_objects_delayed > 0) {
			BeaconCommon::PostSlackMessage('There ' . ($new_objects_delayed == 1 ? 'is 1 new object' : 'are ' . $new_objects_delayed . ' new objects') . ' in the usercloud queue that failed to upload after multiple attempts.');
		}

		static::CleanupLocalCache(0);
	}

	public static function ListFiles(string $remote_path): array {
		$remote_path = static::CleanupRemotePath($remote_path);
		if (substr($remote_path, -1, 1) != '/') {
			$remote_path .= '/';
		}

		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT remote_path, content_type, size_in_bytes, modified, deleted, header, hash FROM usercloud WHERE remote_path LIKE $1;', "$remote_path%");
		$files = [];
		while (!$results->EOF()) {
			$files[] = [
				'path' => $results->Field('remote_path'),
				'type' => $results->Field('content_type'),
				'size' => intval($results->Field('size_in_bytes')),
				'modified' => $results->Field('modified'),
				'deleted' => $results->Field('deleted'),
				'header' => $results->Field('header'),
				'hash' => $results->Field('hash')
			];
			$results->MoveNext();
		}
		return $files;
	}

	public static function GetFile(string $remote_path, bool $with_exceptions = false, ?string $version_id = null): string {
		$remote_path = static::CleanupRemotePath($remote_path);

		$local_path = static::WarmFile($remote_path, $version_id);
		if (is_int($local_path)) {
			if ($with_exceptions) {
				throw new Exception('Failed to retrieve file from storage server', $local_path);
			} else {
				return '';
			}
		}

		return file_get_contents($local_path);
	}

	public static function StreamFile(string $remote_path, ?string $version_id = null): bool {
		$local_path = static::WarmFile($remote_path, $version_id);
		if (is_int($local_path)) {
			switch ($local_path) {
			case static::FILE_NOT_FOUND:
				http_response_code(404);
				echo "File not found";
				break;
			case static::FAILED_TO_WARM_CACHE:
				http_response_code(500);
				echo "Unable to retrieve $remote_path from storage server";
				break;
			default:
				http_response_code(500);
				echo "Failed to warm cache: $local_path";
				break;
			}
			exit;
		}

		$handle = fopen($local_path, 'rb');
		if ($handle === false) {
			http_response_code(500);
			echo "Unable to open $local_path";
			return false;
		}

		while (ob_get_level() > 0) {
			ob_end_clean();
		}

		$filesize = filesize($local_path);
		http_response_code(200);
		header('X-Accel-Buffering: no');
		header('Content-Length: ' . $filesize);
		header('Content-Type: ' . static::MimeForPath($local_path));
		while (!feof($handle)) {
			$chunk = fread($handle, 1024);
			echo $chunk;
			flush();
		}
		fclose($handle);

		return true;
	}

	public static function PutFile(string $remote_path, string|array $file_contents): bool {
		// determine if the file has changed
		$legacy_mode = is_array($file_contents) === false;
		if ($legacy_mode) {
			$hash = hash('sha256', $file_contents);
		} else {
			$hash = hash_file('sha256', $file_contents['tmp_name']);
		}

		$database = BeaconCommon::Database();
		$file_exists = false;
		$results = $database->Query('SELECT hash, deleted FROM usercloud WHERE remote_path = $1;', $remote_path);
		if ($results->RecordCount() == 1) {
			$file_exists = true;
			if ($results->Field('hash') === $hash && $results->Field('deleted') === false) {
				// nope, same file
				return true;
			}
		}

		// see if the file is cached already
		$hostname = gethostname();
		$cache_id = null;
		$results = $database->Query('SELECT cache_id FROM usercloud_cache WHERE hostname = $1 AND remote_path = $2;', $hostname, $remote_path);
		if ($results->RecordCount() == 1) {
			$cache_id = $results->Field('cache_id');
		}

		// make sure the local cache has the required space
		if ($legacy_mode) {
			$filesize = strlen($file_contents);
		} else {
			$filesize = filesize($file_contents['tmp_name']);
		}
		static::CleanupLocalCache($filesize);

		// store the file locally
		$remote_path = static::CleanupRemotePath($remote_path);
		$local_path = static::LocalPath($remote_path);
		$content_type = static::MimeForPath($local_path);
		$parent = dirname($local_path);
		static::SetupDir($parent);
		if ($legacy_mode) {
			file_put_contents($local_path, $file_contents);
			$header_bytes = BeaconEncryption::HeaderBytes($file_contents, false);
		} else {
			if (move_uploaded_file($file_contents['tmp_name'], $local_path) === false) {
				return false;
			}
			$header_bytes = BeaconEncryption::HeaderBytes($local_path, true);
		}
		if (is_null($header_bytes) === false) {
			$header_bytes = bin2hex($header_bytes);
		}
		chmod($local_path, 0640);
		chgrp($local_path, 'cacheshare');

		// update the database
		$database->BeginTransaction();
		if ($file_exists) {
			$database->Query('UPDATE usercloud SET content_type = $2, size_in_bytes = $3, hash = $4, modified = CURRENT_TIMESTAMP, deleted = FALSE, header = $5 WHERE remote_path = $1;', $remote_path, $content_type, $filesize, $hash, $header_bytes);
		} else {
			$database->Query('INSERT INTO usercloud (remote_path, content_type, size_in_bytes, hash, modified, header, bucket) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, $5, $6);', $remote_path, $content_type, $filesize, $hash, $header_bytes, static::PrimaryBucket());
		}
		if (is_null($cache_id)) {
			$database->Query('INSERT INTO usercloud_cache (hostname, remote_path, size_in_bytes, hash) VALUES ($1, $2, $3, $4);', $hostname, $remote_path, $filesize, $hash);
		} else {
			$database->Query('UPDATE usercloud_cache SET size_in_bytes = $3, hash = $4, last_accessed = CURRENT_TIMESTAMP WHERE hostname = $1 AND remote_path = $2;', $hostname, $remote_path, $filesize, $hash);
		}
		$database->Query('DELETE FROM usercloud_queue WHERE remote_path = $1;', $remote_path);
		$database->Query('INSERT INTO usercloud_queue (remote_path, hostname, request_method) VALUES ($1, $2, $3);', $remote_path, $hostname, 'PUT');
		$database->Commit();
		return true;
	}

	public static function DeleteFile(string $remote_path): void {
		$remote_path = static::CleanupRemotePath($remote_path);
		$local_path = static::LocalPath($remote_path);
		if (file_exists($local_path)) {
			static::DeleteLocalPath($local_path);
		}

		$hostname = gethostname();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE usercloud SET modified = CURRENT_TIMESTAMP, deleted = TRUE WHERE remote_path = $1;', $remote_path);
		$database->Query('DELETE FROM usercloud_queue WHERE remote_path = $1;', $remote_path);
		$database->Query('DELETE FROM usercloud_cache WHERE hostname = $1 AND remote_path = $2;', $hostname, $remote_path);
		$database->Query('INSERT INTO usercloud_queue (hostname, remote_path, request_method) VALUES ($1, $2, $3);', $hostname, $remote_path, 'DELETE');
		$database->Commit();
	}

	public static function VersionsForFile(string $remotePath, ?string $overrideBucketPath = null): array|bool {
		$remotePath = static::CleanupRemotePath($remotePath);

		if (is_null($overrideBucketPath)) {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT bucket FROM usercloud WHERE remote_path = $1;', $remotePath);
			if ($rows->RecordCount() !== 1) {
				throw new Exception('File not found');
			}
			$bucketPath = $rows->Field('bucket');
		} else {
			$bucketPath = $overrideBucketPath;
		}

		$path = '/?versions&prefix=' . urlencode(substr($remotePath, 1));
		$url = static::BuildSignedURL($bucketPath, $path, 'GET');

		$curl = curl_init();
		if ($curl === false) {
			throw new Exception('Unable to get curl handle');
		}
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
		$response = curl_exec($curl);
		$success = false;
		$httpStatus = 0;
		if ($response !== false) {
			$httpStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
			$success = $httpStatus >= 200 && $httpStatus < 300;
		}
		curl_close($curl);

		if ($success === false) {
			$nextBucket = static::NextBucket($bucketPath);
			if (is_null($nextBucket) === false) {
				return static::VersionsForFile($remotePath, $nextBucket);
			} else {
				return false;
			}
		}

		$xml = simplexml_load_string($response);
		if ($xml === false) {
			return false;
		}

		$versions = [];
		if ($xml->Version->count() === 0) {
			return $versions;
		}

		$elements = $xml->Version;
		foreach ($elements as $element) {
			$isLatest = strval($element->IsLatest[0]) === 'true';
			$versionId = strval($element->VersionId[0]);
			if ($versionId === 'null') {
				// not sure what this is all about
				continue;
			}
			$date = new DateTime(strval($element->LastModified));
			$bytes = intval($element->Size);
			$versions[] = [
				'latest' => $isLatest,
				'version_id' => $versionId,
				'date' => $date->format('Y-m-d H:i:sO'),
				'size' => $bytes
			];
		}

		return $versions;
	}

	private static function SetupDir(string $path): void {
		if (file_exists($path)) {
			if (is_dir($path)) {
				return;
			} else {
				unlink($path);
			}
		}

		static::SetupDir(dirname($path));
		mkdir($path, 0750, false);
		chgrp($path, 'cacheshare');
	}

	private static function PrimaryBucket(): string {
		$buckets = BeaconCommon::GetGlobal('Storage_Buckets');
		return $buckets[0];
	}

	private static function AllBuckets(?string $initialBucket = null): array {
		$buckets = BeaconCommon::GetGlobal('Storage_Buckets');
		if (is_null($initialBucket)) {
			return $buckets;
		}

		$remainingBuckets = array_filter($buckets, function($value) use ($initialBucket) {
			return $value !== $initialBucket;
		});

		return array_merge([$initialBucket], $remainingBuckets);
	}

	private static function NextBucket(string $currentBucket): ?string {
		$buckets = BeaconCommon::GetGlobal('Storage_Buckets');
		$lastIndex = count($buckets) - 1;
		$currentIndex = array_search($currentBucket, $buckets);
		if ($currentIndex < $lastIndex) {
			return $buckets[$currentIndex + 1];
		}
		return null;
	}
}

?>

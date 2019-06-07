<?php

abstract class BeaconCloudStorage {
	const FILE_NOT_FOUND = 404;
	const FAILED_TO_WARM_CACHE = 500;
	const STORAGE_LIMIT = 2147483648;
	
	private static $curl = array();
	
	private static function cURLHandle(string $id) {
		if (!array_key_exists($id, static::$curl)) {
			static::$curl[$id] = curl_init();
		}
		return static::$curl[$id];
	}
	
	private static function BucketName() {
		return BeaconCommon::InProduction() ? 'beacon-usercloud' : 'beacon-usercloud-dev';
	}
	
	private static function CleanupRemotePath(string $remote_path) {
		if (substr($remote_path, 0, 1) != '/') {
			$remote_path = '/' . $remote_path;
		}
		return $remote_path;
	}
	
	private static function LocalPath(string $remote_path) {
		return sys_get_temp_dir() . static::ResourcePath($remote_path);
	}
	
	private static function ResourcePath(string $remote_path) {
		return '/' . static::BucketName() . static::CleanupRemotePath($remote_path);
	}
	
	private static function CleanupLocalCache(int $required_bytes) {
		$hostname = gethostname();
		$database = BeaconCommon::Database();
		$target_bytes = max(static::STORAGE_LIMIT - $required_bytes, 0);
		
		$database->BeginTransaction();
		$results = $database->Query('SELECT cache_id, remote_path FROM usercloud_cache WHERE last_accessed < CURRENT_TIMESTAMP - \'2 days\'::INTERVAL AND remote_path NOT IN (SELECT remote_path FROM usercloud_queue);');
		while (!$results->EOF()) {
			$remote_path = $results->Field('remote_path');
			
			if (file_exists($local_path)) {
				unlink($local_path);
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
				unlink($local_path);
				$database->Query('DELETE FROM usercloud_cache WHERE cache_id = $1;', $cache_id);
				$consumed_bytes = max($consumed_bytes - $size_in_bytes, 0);
			}
			
			$results->MoveNext();
		}
		$database->Commit();
	}
	
	private static function MimeForPath(string $local_path) {
		$extension = strtolower(pathinfo($local_path, PATHINFO_EXTENSION));
		
		switch ($extension) {
		case 'beacon':
		case 'beaconpreset':
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
	
	private static function BuildSignedURL(string $remote_path, string $method) {
		$expiration = time() + 60;
		$resource_path = static::ResourcePath($remote_path);
		$str_to_sign = implode("\n", array($method, '', '', $expiration, $resource_path));
		$signature = base64_encode(hash_hmac('sha1', $str_to_sign, BeaconCommon::GetGlobal('Storage_Password'), true));
		return 'https://' . BeaconCommon::GetGlobal('Storage_Host') . $resource_path . '?AWSAccessKeyId=' . urlencode(BeaconCommon::GetGlobal('Storage_Username')) . '&Expires=' . urlencode($expiration) . '&Signature=' . urlencode($signature);
	}
	
	private static function WarmFile(string $remote_path) {
		$remote_path = static::CleanupRemotePath($remote_path);
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT hash, size_in_bytes FROM usercloud WHERE remote_path = $1;', $remote_path);
		if ($results->RecordCount() == 0) {
			return static::FILE_NOT_FOUND;
		}
		$correct_hash = $results->Field('hash');
		$filesize = $results->Field('size_in_bytes');
		$hostname = gethostname();
		$results = $database->Query('SELECT cache_id, hash FROM usercloud_cache WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname);
		$is_cached = false;
		$cache_id = null;
		if ($results->RecordCount() == 1) {
			$cache_id = $results->Field('cache_id');
			$cached_hash = $results->Field('hash');
			if ($cached_hash === $correct_hash) {
				$is_cached = true;
			}
		}
		
		$local_path = static::LocalPath($remote_path);
		if (file_exists($local_path) === false || $is_cached === false) {
			static::CleanupLocalCache($filesize);
			
			$parent = dirname($local_path);
			if (file_exists($parent) == false) {
				mkdir($parent, 0770, true);
			} elseif (is_dir($parent) == false) {
				unlink($parent);
				mkdir($parent, 0770, true);
			}
			
			$url = static::BuildSignedURL($remote_path, 'GET');
			$remote_handle = @fopen($url, 'rb');
			if (!$remote_handle) {
				return static::FAILED_TO_WARM_CACHE;
			}
			$local_handle = fopen($local_path, 'wb');
			while (!feof($remote_handle)) {
				$chunk = fread($remote_handle, 1024);
				fwrite($local_handle, $chunk);
			}
			fclose($local_handle);
			fclose($remote_handle);
			
			chmod($local_path, 0660);
		}
		
		$filesize = filesize($local_path);
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		if (!is_null($cache_id)) {
			$database->Query('UPDATE usercloud_cache SET size_in_bytes = $2, hash = $3, last_accessed = CURRENT_TIMESTAMP WHERE cache_id = $1;', $cache_id, $filesize, $correct_hash);
		} else {
			$database->Query('INSERT INTO usercloud_cache (hostname, remote_path, size_in_bytes, hash) VALUES ($1, $2, $3, $4)', $hostname, $remote_path, $filesize, $correct_hash);
		}
		$database->Commit();
		
		return $local_path;
	}
	
	public static function RunQueue() {
		$hostname = gethostname();
		$database = BeaconCommon::Database();
		while (true) {
			$database->BeginTransaction();
			$results = $database->Query('SELECT usercloud_queue.remote_path, usercloud_queue.request_method, usercloud.content_type FROM usercloud_queue LEFT JOIN usercloud ON (usercloud_queue.remote_path = usercloud.remote_path) WHERE usercloud_queue.hostname = $1 AND usercloud_queue.http_status IS NULL ORDER BY usercloud_queue.queue_time ASC LIMIT 1 FOR UPDATE OF usercloud_queue SKIP LOCKED;', $hostname);
			if ($results->RecordCount() == 0) {
				$database->Rollback();
				return;
			}
			
			$remote_path = $results->Field('remote_path');
			$local_path = static::LocalPath($remote_path);
			$request_method = $results->Field('request_method');
			$content_type = $results->Field('content_type');
			$date = gmdate('Y-m-d\TH:i:s\Z', time());
			$resource_path = static::ResourcePath($remote_path);
			$str_to_sign = implode("\n", array($request_method, '', $content_type, $date, $resource_path));
			$signature = base64_encode(hash_hmac('sha1', $str_to_sign, BeaconCommon::GetGlobal('Storage_Password'), true));
			
			$curl = static::cURLHandle($request_method);
			curl_setopt($curl, CURLOPT_URL, 'https://' . BeaconCommon::GetGlobal('Storage_Host') . $resource_path);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_HTTPHEADER, array(
					'Authorization: AWS ' . BeaconCommon::GetGlobal('Storage_Username') . ':' . $signature,
					'Date: ' . $date,
					'Content-Type: ' . $content_type
				)
			);
			curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
			switch ($request_method) {
			case 'PUT':
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
			curl_close($curl);
			
			if ($success) {
				$database->Query('DELETE FROM usercloud_queue WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname);
			} else {
				$database->Query('UPDATE usercloud_queue SET http_status = $3 WHERE remote_path = $1 AND hostname = $2;', $remote_path, $hostname, $http_status);
				BeaconCommon::PostSlackMessage('Unable to ' . $request_method . ' ' . $remote_path . ', http status ' . $http_status);
			}
			
			$database->Commit();
		}
		
		static::CleanupLocalCache(0);
	}
	
	public static function ListFiles(string $remote_path) {
		$remote_path = static::CleanupRemotePath($remote_path);
		if (substr($remote_path, -1, 1) != '/') {
			$remote_path .= '/';
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT remote_path, content_type, size_in_bytes, modified, deleted, header FROM usercloud WHERE remote_path LIKE $1;', "$remote_path%");
		$files = array();
		while (!$results->EOF()) {
			$files[] = array(
				'path' => $results->Field('remote_path'),
				'type' => $results->Field('content_type'),
				'size' => $results->Field('size_in_bytes'),
				'modified' => $results->Field('modified'),
				'deleted' => $results->Field('deleted'),
				'header' => $results->Field('header')
			);
			$results->MoveNext();
		}
		return $files;
	}
	
	public static function GetFile(string $remote_path) {
		$remote_path = static::CleanupRemotePath($remote_path);
		
		$local_path = static::WarmFile($remote_path);
		if (is_int($local_path)) {
			return '';
		}
		
		return file_get_contents($local_path);
	}
	
	public static function StreamFile(string $remote_path) {
		$local_path = static::WarmFile($remote_path);
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
	
	public static function PutFile(string $remote_path, string $file_contents) {
		// determine if the file has changed
		$hash = hash('sha256', $file_contents);
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
		$filesize = strlen($file_contents);
		static::CleanupLocalCache($filesize);
		
		// store the file locally
		$remote_path = static::CleanupRemotePath($remote_path);
		$local_path = static::LocalPath($remote_path);
		$content_type = static::MimeForPath($local_path);
		$parent = dirname($local_path);
		if (file_exists($parent) == false) {
			mkdir($parent, 0770, true);
		} elseif (is_dir($parent) == false) {
			unlink($parent);
			mkdir($parent, 0770, true);
		}
		file_put_contents($local_path, $file_contents);
		chmod($local_path, 0660);
		
		// get the header, if the file is encrypted
		$header_bytes = BeaconEncryption::HeaderBytes($file_contents);
		if (!is_null($header_bytes)) {
			$header_bytes = bin2hex($header_bytes);
		}
		
		// update the database
		$database->BeginTransaction();
		if ($file_exists) {
			$database->Query('UPDATE usercloud SET content_type = $2, size_in_bytes = $3, hash = $4, modified = CURRENT_TIMESTAMP, deleted = FALSE, header = $5 WHERE remote_path = $1;', $remote_path, $content_type, $filesize, $hash, $header_bytes);
		} else {
			$database->Query('INSERT INTO usercloud (remote_path, content_type, size_in_bytes, hash, modified, header) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, $5);', $remote_path, $content_type, $filesize, $hash, $header_bytes);
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
	
	public static function DeleteFile(string $remote_path) {
		$remote_path = static::CleanupRemotePath($remote_path);
		$local_path = static::LocalPath($remote_path);
		if (file_exists($local_path)) {
			unlink($local_path);
		}
		
		$hostname = gethostname();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE usercloud SET modified = CURRENT_TIMESTAMP, deleted = TRUE WHERE remote_path = $1;', $remote_path);
		$database->Query('DELETE FROM usercloud_queue WHERE hostname = $1 AND remote_path = $2;', $hostname, $remote_path);
		$database->Query('DELETE FROM usercloud_cache WHERE hostname = $1 AND remote_path = $2;', $hostname, $remote_path);
		$database->Query('INSERT INTO usercloud_queue (hostname, remote_path, request_method) VALUES ($1, $2, $3);', $hostname, $remote_path, 'DELETE');
		$database->Commit();
	}
}
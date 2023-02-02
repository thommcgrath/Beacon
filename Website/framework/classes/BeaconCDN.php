<?php

class BeaconCDN {
	protected $endpoint;
	protected $zoneName;
	protected $zoneDomain;
	protected $apiKey;
	
	public function __construct(string $endpoint, string $zoneName, string $zoneDomain, string $apiKey) {
		$this->endpoint = $endpoint;
		$this->zoneName = $zoneName;
		$this->zoneDomain = $zoneDomain;
		$this->apiKey = $apiKey;
	}
	
	public function ListFiles(string $basePath): array {
		if (str_starts_with($basePath, '/')) {
			$basePath = substr($basePath, 1);
		}
		if (str_ends_with($basePath, '/') === false) {
			$basePath .= '/';
		}
		
		$curl = curl_init("https://{$this->endpoint}/{$this->zoneName}/{$path}");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'GET');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'AccessKey: ' . $this->apiKey
		]);
		$response = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($http_status !== 200) {
			throw new Exception($response);
		}
		
		$fileList = json_decode($response, true);
		$files = [];
		foreach ($fileList as $fileInfo) {
			$filename = $fileInfo['ObjectName'];
			if ($fileInfo['IsDirectory']) {
				$filename .= '/';
			}
			$files[] = $filename;
		}
		
		return $files;
	}
	
	public function PutFile(string $path, string $content): void {
		if (str_starts_with($path, '/')) {
			$path = substr($path, 1);
		}
		
		$curl = curl_init("https://{$this->endpoint}/{$this->zoneName}/{$path}");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'PUT');
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'AccessKey: ' . $this->apiKey,
			//'Checksum: ' . hash('sha256', $content),
			'Content-Type: application/octet-stream'
		]);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $content);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_BINARYTRANSFER, true);
		$response = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($http_status !== 201) {
			throw new Exception('File was not accepted by BunnyCDN');
		}
		
		$purgeUrl = urlencode("https://{$this->zoneDomain}/{$path}");
		$curl = curl_init("https://api.bunny.net/purge?url={$purgeUrl}");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'AccessKey: ' . BeaconCommon::GetGlobal('BunnyCDN API Key')
		]);
		$response = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
	}
	
	public function DeleteFile(string $path): void {
		if (str_starts_with($path, '/')) {
			$path = substr($path, 1);
		}
		
		$curl = curl_init("https://{$this->endpoint}/{$this->zoneName}/{$path}");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'DELETE');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'AccessKey: ' . $this->apiKey
		]);
		$response = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($http_status !== 200) {
			throw new Exception($response);
		}
	}
	
	public function GetFile(string $path): string {
		if (str_starts_with($path, '/')) {
			$path = substr($path, 1);
		}
		
		$curl = curl_init("https://{$this->endpoint}/{$this->zoneName}/{$path}");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'GET');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, [
			'AccessKey: ' . $this->apiKey
		]);
		$response = curl_exec($curl);
		$http_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		
		if ($http_status !== 200) {
			throw new Exception($response);
		}
		
		return $response;
	}
	
	public static function AssetsZone(): BeaconCDN {
		$endpoint = 'ny.storage.bunnycdn.com';
		$zoneName = 'beacon-assets';
		$zoneDomain = 'assets.usebeacon.app';
		$apiKey = BeaconCommon::GetGlobal('BunnyCDN Assets Zone Key');
		return new BeaconCDN($endpoint, $zoneName, $zoneDomain, $apiKey);
	}
	
	public static function DeltasZone(): BeaconCDN {
		$endpoint = 'ny.storage.bunnycdn.com';
		$zoneName = 'beacon-updates';
		$zoneDomain = 'updates.usebeacon.app';
		$apiKey = BeaconCommon::GetGlobal('BunnyCDN_Deltas_Password');
		return new BeaconCDN($endpoint, $zoneName, $zoneDomain, $apiKey);
	}
}

?>

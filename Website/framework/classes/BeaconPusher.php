<?php

class BeaconPusher {
	protected string $appId;
	protected string $appKey;
	protected string $appSecret;
	protected string $appCluster;

	protected static $instance;

	public function __construct() {
		$this->appId = BeaconCommon::GetGlobal('Pusher Id');
		$this->appKey = BeaconCommon::GetGlobal('Pusher Key');
		$this->appSecret = BeaconCommon::GetGlobal('Pusher Secret');
		$this->appCluster = BeaconCommon::GetGlobal('Pusher Cluster');
	}

	public static function SharedInstance(): static {
		if (is_null(static::$instance)) {
			static::$instance = new static();
		}
		return static::$instance;
	}

	public function TriggerEvent(string $channelName, string $eventName, mixed $eventBody, string $senderSocketId = ''): bool {
		$bodyJson = [
			'name' => $eventName,
			'data' => json_encode($eventBody),
			'channel' => $channelName,
		];
		if (empty($senderSocketId) === false) {
			$bodyJson['socket_id'] = $senderSocketId;
		}
		$body = json_encode($bodyJson);

		$authTimestamp = time();
		$authVersion = '1.0';
		$bodyHash = md5($body);
		$url = '/apps/' . $this->appId . '/events';
		$key = $this->appKey;

		$stringToSign = "POST\n{$url}\nauth_key={$key}&auth_timestamp={$authTimestamp}&auth_version={$authVersion}&body_md5={$bodyHash}";
		$signature = hash_hmac('sha256', $stringToSign, $this->appSecret);

		$url = 'https://api.pusherapp.com' . $url . '?' . http_build_query([
			'auth_key' => $key,
			'auth_signature' => $signature,
			'auth_timestamp' => $authTimestamp,
			'auth_version' => $authVersion,
			'body_md5' => $bodyHash,
		]);

		$curl = curl_init($url);
		$headers = [
			'Content-Type: application/json',
		];
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_POST, 1);
		curl_setopt($curl, CURLOPT_POSTFIELDS, $body);
		$response = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

		return $status === 200;
	}

	public static function SocketIdFromHeaders(): string {
		return $_SERVER['HTTP_X_BEACON_PUSHER_ID'] ?? '';
	}

	public static function UserChannelName(string $userId): string {
		return 'user-' . str_replace('-', '', $userId);
	}

	public static function ProjectChannelName(string $projectId): string {
		return 'project-' . str_replace('-', '', $projectId);
	}
}

?>

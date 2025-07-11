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

	public function TriggerEvent(string $channelName, string $eventName, mixed $eventBody, ?string $senderSocketId = null): void {
		$this->SendEvents([new BeaconChannelEvent(channelName: $channelName, eventName: $eventName, body: $eventBody, socketId: $senderSocketId)]);
	}

	public function SendEvents(array $events): void {
		if (count($events) === 0) {
			return;
		}

		for ($startIndex = 0; $startIndex < count($events); $startIndex += 10) {
			$batch = [];
			for ($idx = $startIndex; $idx < min($startIndex + 10, count($events)); $idx++) {
				$batch[] = $events[$idx];
			}

			$body = json_encode(['batch' => $batch]);
			$authTimestamp = time();
			$authVersion = '1.0';
			$bodyHash = md5($body);
			$url = '/apps/' . $this->appId . '/batch_events';
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
			$errorNumber = curl_errno($curl);
			$errorMessage = curl_error($curl);
			curl_close($curl);

			if ($response === false) {
				throw new Exception("CURL Error {$errorNumber}: {$errorMessage}");
			} elseif ($status !== 200) {
				throw new Exception("Unexpected HTTP {$status} response: {$response}");
			}
		}
	}

	public function SendEvent(BeaconChannelEvent $event): void {
		$this->SendEvents([$event]);
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

	public static function PrivateUserChannelName(string $userId): string {
		return 'private-users.' . strtolower($userId);
	}

	public static function PrivateProjectChannelName(string $projectId): string {
		return 'private-projects.' . strtolower($projectId);
	}

	public static function SentinelChannelName(string $prefix, string $id): string {
		return 'private-sentinel.' . $prefix . '.' . $id;
	}
}

?>

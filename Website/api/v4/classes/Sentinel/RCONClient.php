<?php

namespace BeaconAPI\v4\Sentinel;
use Exception;

class RCONClient {
	private $host = null;
	private $port = null;
	private $password = null;
	private $timeout = 3;
	private $socket = null;
	private $isAuthorized = false;
	private $lastReply = null;
	
	const ServerDataAuth = 3;
	const ServerDataAuthResponse = 2;
	const ServerDataExecuteCommand = 2;
	const ServerDataResponseValue = 0;
	
	public function __construct(string $host, int $port, string $password, int $timeout = 3) {
		$this->host = $host;
		$this->port = $port;
		$this->password = $password;
		$this->timeout = $timeout;
	}
	
	public function Connect(): void {
		$error_number = null;
		$error_string = null;
		$socket = fsockopen($this->host, $this->port, $error_number, $error_string, $this->timeout);
		if (!$socket) {
			throw new Exception('Could not open RCON connection, error ' . $error_number . ': ' . $error_string);
		}
		
		stream_set_timeout($socket, $this->timeout);
		
		$this->socket = $socket;
		
		if ($this->Authorize() === false) {
			throw new Exception('Authorization failed');
		}
	}
	
	public function Authorize(): bool {
		$id = random_int(1, 9999);
		$this->WritePacket($id, self::ServerDataAuth, $this->password);
		$response = $this->ReadPacket();
		
		if ($response['id'] === $id && $response['type'] === self::ServerDataAuthResponse) {
			$this->isAuthorized = true;
			return true;
		}
		
		return false;
	}
	
	public function Disconnect(): void {
		if ($this->socket) {
			fclose($this->socket);
			$this->socket = null;
		}
	}
	
	public function IsAuthorized(): bool {
		return $this->isAuthorized;
	}
	
	public function SendCommand(string $command): ?string {
		if ($this->IsAuthorized() === false) {
			return null;
		}
		
		$id = random_int(1, 9999);
		$this->WritePacket($id, self::ServerDataExecuteCommand, $command);
		
		$response = $this->ReadPacket();
		if ($response['id'] === $id && $response['type'] === self::ServerDataResponseValue) {
			var_dump($response);
			return $response['body'];
		}
		
		return null;
	}
	
	private function WritePacket(int $id, int $type, string $body): void {
		$packet = pack('V', $id);
		$packet .= pack('V', $type);
		$packet .= $body . "\x00\x00";
		
		$size = strlen($packet);
		
		$packet = pack('V', $size) . $packet;
		
		fwrite($this->socket, $packet, strlen($packet));
	}
	
	private function ReadPacket(): ?array {
		$packet_size = fread($this->socket, 4);
		$packet = unpack('v1size', $packet_size);
		$size = $packet['size'];
		
		$packet = fread($this->socket, $size);
		$body = unpack('V1id/V1type/a*body', $packet);
		
		return $body;
	}
}
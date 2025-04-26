<?php

class BeaconChannelEvent implements JsonSerializable {
	protected mixed $body;
	protected string $channelName;
	protected string $eventName;
	protected ?string $socketId;

	public function __construct(string $channelName, string $eventName, mixed $body, ?string $socketId = null) {
		$this->channelName = $channelName;
		$this->eventName = $eventName;
		$this->body = $body;
		$this->socketId = $socketId;
	}

	public function Body(): mixed {
		return $this->body;
	}

	public function ChannelName(): string {
		return $this->channelName;
	}

	public function EventName(): string {
		return $this->eventName;
	}

	public function SocketId(): ?string {
		return $this->socketId;
	}

	public function Signature(): string {
		return bin2hex(hash('sha3-256', json_encode($this)));
	}

	public function jsonSerialize(): mixed {
		$serialized = [
			'name' => $this->eventName,
			'channel' => $this->channelName,
			'data' => json_encode($this->body),
		];
		if (empty($this->socketId) === false) {
			$serialized['socket_id'] = $this->socketId;
		}
		return $serialized;
	}
}

?>

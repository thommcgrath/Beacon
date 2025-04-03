<?php

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;
use PhpAmqpLib\Channel\AMQPChannel;

abstract class BeaconRabbitMQ {
	protected static ?AMQPStreamConnection $connection = null;
	protected static ?AMQPChannel $channel = null;

	public static function SendMessage(string $exchange, string $routeKey, string $message): void {
		if (is_null(static::$connection)) {
			static::$connection = new AMQPStreamConnection(BeaconCommon::GetGlobal('RabbitMQ Host'), BeaconCommon::GetGlobal('RabbitMQ Port'), BeaconCommon::GetGlobal('RabbitMQ User'), BeaconCommon::GetGlobal('RabbitMQ Password'), BeaconCommon::GetGlobal('RabbitMQ Virtual Host'));
			static::$channel = static::$connection->channel();
			//static::$channel->queue_declare('', false, false, false, true);
		}
		static::$channel->basic_publish(new AMQPMessage($message), $exchange, $routeKey);
	}
}

?>

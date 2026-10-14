<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{DatabaseObject, MutableDatabaseObject};
use BeaconCommon, BeaconRabbitMQ, Exception;

trait Admin {
	use MutableDatabaseObject {
		Create as protected MDOCreate;
		Delete as protected MDODelete;
	}

	public static function Create(array $properties): DatabaseObject {
		// We need to tell affected servers. But we don't know what we're creating yet.
		$database = BeaconCommon::Database();
		$previousServiceIds = [];
		try {
			$rows = $database->Query('SELECT DISTINCT service_id FROM sentinel.admins WHERE player_id = $1;', $properties['playerId']);
			while (!$rows->EOF()) {
				$previousServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}
		} catch (Exception $err) {
		}

		$obj = static::MDOCreate($properties);

		try {
			$rows = $database->Query('SELECT player_identifiers.identifier FROM sentinel.player_identifiers INNER JOIN sentinel.admins ON (admins.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE admins.player_id = $2;', 'EOS', $obj->playerId);
			$epicId = $rows->Field('identifier');

			$rows = $database->Query('SELECT DISTINCT service_id FROM sentinel.admins WHERE player_id = $1;', $obj->playerId);
			while (!$rows->EOF()) {
				$serviceId =  $rows->Field('service_id');
				if (in_array($serviceId, $previousServiceIds)) {
					$rows->MoveNext();
					continue;
				}

				$message = [
					'type' => 'setPlayerAdmin',
					'playerId' => $epicId,
					'isAdmin' => true,
				];
				BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.services.' . $serviceId . '.gameCommand', json_encode($message));

				$rows->MoveNext();
			}
		} catch (Exception $err) {
		}

		return $obj;
	}

	public function Delete(): void {
		$previousServiceIds = [];
		$playerId = $this->playerId;
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT DISTINCT service_id FROM sentinel.admins WHERE player_id = $1;', $playerId);
		while (!$rows->EOF()) {
			$previousServiceIds[] = $rows->Field('service_id');
			$rows->MoveNext();
		}

		$this->MDODelete();

		if (count($previousServiceIds) > 0) {
			$newServiceIds = [];
			$rows = $database->Query('SELECT DISTINCT service_id FROM sentinel.admins WHERE player_id = $1;', $playerId);
			while (!$rows->EOF()) {
				$newServiceIds[] = $rows->Field('service_id');
				$rows->MoveNext();
			}

			$differences = array_diff($previousServiceIds, $newServiceIds);
			if (count($differences) > 0) {
				$rows = $database->Query('SELECT identifier FROM sentinel.player_identifiers WHERE player_id = $1 AND provider = $2;', $playerId, 'EOS');
				$epicId = $rows->Field('identifier');
				foreach ($differences as $serviceId) {
					$message = [
						'type' => 'setPlayerAdmin',
						'playerId' => $epicId,
						'isAdmin' => false,
					];
					BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.services.' . $serviceId . '.gameCommand', json_encode($message));
				}
			}
		}
	}
}

?>

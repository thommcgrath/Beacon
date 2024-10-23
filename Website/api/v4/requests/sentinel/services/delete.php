<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Service};

$requiredScopes[] = Application::kScopeSentinelServicesDelete;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$serviceIds = [];
	if (isset($context['pathParameters']['serviceId'])) {
		$serviceIds = explode(',', $context['pathParameters']['serviceId']);
	} elseif (Core::IsJsonContentType()) {
		$body = Core::BodyAsJson();
		if (BeaconCommon::IsAssoc($body)) {
			foreach ($body as $service) {
				$serviceIds[] = $service['serviceId'];
			}
		} else {
			$serviceIds = $body;
		}
	}

	if (count($serviceIds) <= 0) {
		return Response::NewJsonError('No services were specified to be deleted.', $serviceIds, 400);
	}
	foreach ($serviceIds as $serviceId) {
		if (BeaconCommon::IsUUID($serviceId) === false) {
			return Response::NewJsonError('Service ids should be UUIDs', $serviceIds, 400);
		}
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceIds as $serviceId) {
		$service = Service::Fetch($serviceId);
		if ($service && $service->HasPermission($userId, PermissionBits::ServiceDelete)) {
			try {
				$service->Delete();
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError("There was an error deleting service {$serviceId}", ['error' => $err, 'serviceId' => $serviceId], 500);
			}
		} else {
			$database->Rollback();
			return Response::NewJsonError("Service {$serviceId} not found.", ['serviceId' => $serviceId], 404);
		}
	}
	try {
		$database->Commit();
		BeaconRabbitMQ::SendMessage('sentinel_watcher', 'com.thezaz.beacon.sentinel.deletedServices', json_encode([
			'serviceIds' => $serviceIds,
		]));
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError("There was an internal error while trying to delete the requested services.", ['error' => $err, 'serviceIds' => $serviceIds], 500);
	}
}

?>

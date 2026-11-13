<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
	$requiredScopes[] = Application::kScopeSentinelWrite;
}

function handleRequest(array $context): Response {
	$serviceId = $context['pathParameters']['serviceId'];
	if (BeaconUUID::Validate($serviceId) === false) {
		return Response::NewJsonError(code: 'badServiceId', httpStatus: 400, message: 'serviceId must be a UUID.');
	}

	$service = Service::Fetch($serviceId);
	if (is_null($service)) {
		return Response::NewJsonError(message: 'Serviced not found', httpStatus: 404, code: 'notFound', details: ['serviceId' => $serviceId]);
	}

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT job_id, completed FROM sentinel.purge_jobs WHERE service_id = $1;', $serviceId);
	if ($rows->RecordCount() === 0) {
		if (Core::Method() === 'POST') {
			$permissions = $service->GetPermissionsForUser(Core::User());
			if (($permissions & PermissionBits::EditServices) !== PermissionBits::EditServices) {
				return Response::NewJsonError(code: 'badPermission', httpStatus: 400, message: 'User must have "edit servers" permission on this service.');
			}

			$database->BeginTransaction();
			$rows = $database->Query('INSERT INTO sentinel.purge_jobs (service_id) VALUES ($1) RETURNING job_id, completed;', $serviceId);
			$database->Commit();

			// Disconnect the server so events stop processing
			BeaconRabbitMQ::SendMessage('sentinel_exchange', "sentinel.services.{$serviceId}.socketCommand", json_encode([
				'command' => 'kick',
			]));
		} else {
			return Response::NewJsonError(code: 'notFound', httpStatus: 404, message: 'No purge job exists for this service.');
		}
	}

	return Response::NewJson([
		'jobId' => $rows->Field('job_id'),
		'completed' => $rows->Field('completed'),
	], 200);
}

?>

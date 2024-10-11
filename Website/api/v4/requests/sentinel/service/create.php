<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest, Subscription};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$serviceRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceRequests = $obj;
		$multiResponse = true;
	}

	$subscriptions = Subscription::Search(['userId' => $userId], true);
	if (count($subscriptions) !== 1) {
		return Response::NewJsonError('You do not have a subscription to Beacon Sentinel.', null, 400);
	}
	$subscription = $subscriptions[0];
	if ($subscription->IsSuspended()) {
		return Response::NewJsonError('Your subscription is currently suspended.', ['subscription' => $subscription], 400);
	}
	if ($subscription->UsedServices() + count($serviceRequests) > $subscription->MaxServices()) {
		$usedServices = number_format($subscription->UsedServices());
		$maxServices = BeaconCommon::NounWithQuantity($subscription->MaxServices(), 'server', 'servers');
		$newServices = BeaconCommon::NounWithQuantity(count($serviceRequests), 'server', 'servers');
		return Response::NewJsonError("You have used {$usedServices} of your {$maxServices}. Adding {$newServices} would put you over the subscription limit.", ['newServiceCount' => count($serviceRequests), 'subscription' => $subscription], 400);
	}

	$newServices = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceRequests as $serviceRequest) {
		$serviceRequest['subscriptionId'] = $subscription->SubscriptionId();
		try {
			$newService = Service::Create($serviceRequest);
			ServiceRefreshRequest::Create([
				'serviceId' => $newService->ServiceId(),
				'userId' => $userId,
			]);
			$newServices[] = $newService;
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not register service: ' . $err->getMessage(), $serviceRequest, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($newServices, 201);
	} else {
		return Response::NewJson($newServices[0], 201);
	}
}

?>

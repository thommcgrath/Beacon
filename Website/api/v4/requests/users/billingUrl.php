<?php

use BeaconAPI\v4\{Application, Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersBilling;
}

function handleRequest(array $context): Response {
	$returnUrl = $_GET['returnUrl'] ?? 'https://usebeacon.app/account';
	if (BeaconCommon::InProduction()) {
		if (preg_match('/^https\:\/\/([^\.]\.)?usebeacon\.app\//i', $returnUrl) === 0) {
			return Response::NewJsonError(message: 'The return url must belong to a Beacon domain.', httpStatus: 400, code: 'badReturnUrl');
		}
	}

	$userId = $context['pathParameters']['userId'];
	$user = Core::User();
	if ($userId !== $user->UserId()) {
		return Response::NewJsonError(message: 'Forbidden.', httpStatus: 403, code: 'forbidden');
	}

	$apiSecret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
	$api = new BeaconStripeAPI($apiSecret, '2022-08-01');
	$customerId = $api->GetCustomerIdForUser($user);
	if (is_null($customerId)) {
		return Response::NewJsonError(message: 'Could not find Stripe customer for this account.', httpStatus: 404, code: 'customerNotFound');
	}
	$portalUrl = $api->GetBillingPortalUrl($customerId, $returnUrl);

	return Response::NewJson([
		'portalUrl' => $portalUrl,
	], 200);
}

?>

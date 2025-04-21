<?php

use BeaconAPI\v4\{Application, Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersBilling;
}

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	$user = Core::User();
	if ($userId !== $user->UserId()) {
		return Response::NewJsonError(message: 'Forbidden.', httpStatus: 403, code: 'forbidden');
	}

	$apiSecret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
	$api = new BeaconStripeAPI($apiSecret, '2022-08-01');

	$customerId = $user->StripeId();
	if (is_null($customerId)) {
		$customerId = $api->GetCustomerIdForUser($user);
		if (is_null($customerId)) {
			return Response::NewJson((object) [], 200);
		}
	}
	$customerSession = $api->CreateCustomerSession([
		'customer' => $customerId,
		'components[pricing_table][enabled]' => 'true',
	]);

	return Response::NewJson([
		'clientSecret' => $customerSession['client_secret'],
	], 200);
}

function handleAnonymousRequest(array $context): Response {
	return Response::NewJson((object) [], 200);
}

?>

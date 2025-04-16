<?php

use BeaconAPI\v4\{Application, Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	if (Core::HasAuthenticationHeader()) {
		Core::Authorize(Core::kAuthSchemeBearer, Application::kScopeCommon);
	} else {
		return Response::NewJson((object) [], 200);
	}

	$apiSecret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
	$api = new BeaconStripeAPI($apiSecret, '2022-08-01');

	$user = Core::User();
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

?>

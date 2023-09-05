<?php

use BeaconAPI\v4\{Response, Core, License};

function handleRequest(array $context): Response {
	$licenseId = $context['pathParameters']['licenseId'];
	$license = License::Fetch($licenseId);
	if ($license->UserId() !== Core::UserId()) {
		return Response::NewJsonError('License not found', null, 404);
	}
	
	if (is_null($license->FirstUsed())) {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE purchases SET first_used = CURRENT_TIMESTAMP WHERE purchase_id = $1;', $license->PurchaseId());
		$database->Commit();
		$license = License::Fetch($licenseId);
	}
	
	return Response::NewJson($license, 200);
}

?>

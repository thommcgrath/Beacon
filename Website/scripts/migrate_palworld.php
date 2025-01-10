#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$now = time();
$database = BeaconCommon::Database();
$database->BeginTransaction();
$rows = $database->Query("SELECT EXTRACT(EPOCH FROM licenses.expiration) AS expiration, purchases.purchaser_email FROM public.licenses INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE licenses.product_id IN ('cc713512-8458-4cd7-8cf3-00bcc03c6b8d', '6780eaa7-9c4d-4b54-8433-66c82abede59') AND purchases.refunded = FALSE;");
while (!$rows->EOF()) {
	$emailId = $rows->Field('purchaser_email');
	$palworldExpiration = $rows->Field('expiration');

	$eolPurchases = $database->Query("SELECT purchase_id FROM public.purchases WHERE purchaser_email = $1 AND notes = 'Palworld End Of Life';", $emailId);
	if ($eolPurchases->RecordCount() > 0) {
		echo "Already processed email {$emailId}.\n";
		$rows->MoveNext();
		continue;
	}

	$daysLeft = max(0, ceil(($palworldExpiration - $now) / 86400));
	if ($daysLeft === 0) {
		echo "License for email {$emailId} has already expired.\n";
		$rows->MoveNext();
		continue;
	}

	$evolvedLicenseRows = $database->Query("SELECT licenses.product_id FROM public.licenses INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 AND licenses.product_id = '972f9fc5-ad64-4f9c-940d-47062e705cc5';", $emailId);
	$hasEvolved = $evolvedLicenseRows->RecordCount() > 0;
	if (!$hasEvolved) {
		BeaconShop::CreateFreePurchase($emailId, '972f9fc5-ad64-4f9c-940d-47062e705cc5', 1, 'Palworld End Of Life', false);
		echo "Issued evolved license to {$emailId}.\n";
	}

	$ascendedLicenseRows = $database->Query("SELECT licenses.license_id, EXTRACT(EPOCH FROM licenses.expiration) AS expiration FROM public.licenses INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 AND licenses.product_id IN (SELECT product_id FROM public.products WHERE game_id = 'ArkSA') ORDER BY licenses.expiration DESC LIMIT 1;", $emailId);
	$hasAscended = $ascendedLicenseRows->RecordCount() > 0;
	if (!$hasAscended) {
		$purchaseId = BeaconShop::CreateFreePurchase($emailId, '673f3018-4ad7-4556-a2c6-0da8548a4b04', 1, 'Palworld End Of Life', false);
		$ascendedLicenseUpdate = $database->Query("UPDATE public.licenses SET expiration = TO_TIMESTAMP($2) WHERE purchase_id = $2;", $purchaseId);
		echo "Issued ascended upgrade to {$emailId} with expiration of {$ascendedLicenseUpdate->Field('expiration')}.\n";
	} else {
		$purchaseId = BeaconShop::CreateFreePurchase($emailId, '8e93c8e1-01f6-4be5-a0a7-856704d96291', 1, 'Palworld End Of Life', false);
		$ascendedExpiration = $ascendedLicenseRows->Field('expiration');
		$ascendedLicenseId = $ascendedLicenseRows->Field('license_id');
		if ($ascendedExpiration < $now) {
			$ascendedLicenseUpdate = $database->Query('UPDATE public.licenses SET expiration = TO_TIMESTAMP($2) WHERE purchase_id = $1 RETURNING expiration;', $purchaseId, $palworldExpiration);
			echo "Ascended license for {$emailId} was expired, so new expiration is {$ascendedLicenseUpdate->Field('expiration')}.\n";
		} else {
			$ascendedLicenseUpdate = $database->Query('UPDATE public.licenses SET expiration = TO_TIMESTAMP($2) + $3::INTERVAL WHERE purchase_id = $1 RETURNING expiration;', $purchaseId, $ascendedExpiration, $daysLeft . ' days');
			echo "Ascended license for {$emailId} was not expired, so expiration has been extended by {$daysLeft} days, to {$ascendedLicenseUpdate->Field('expiration')}.\n";
		}
	}

	$rows->MoveNext();
}
$database->Commit();

echo "Finished\n";

?>

<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Content-Type: application/json');

$supportedKeys = BeaconCommon::GetGlobal('Authentication Keys');
$keys = [];
foreach ($supportedKeys as $keyId => $keyInfo) {
	$key = [
		'kid' => $keyId,
		'use' => 'sig',
		'alg' => 'EdDSA',
		'crv' => 'Ed25519',
		'kty' => 'OKP',
		'x' => sodium_bin2base64(sodium_base642bin($keyInfo['public'], SODIUM_BASE64_VARIANT_ORIGINAL), SODIUM_BASE64_VARIANT_URLSAFE_NO_PADDING),
	];

	$keys[] = $key;
}
echo json_encode($keys, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);

?>

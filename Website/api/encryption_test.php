<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$key = BeaconEncryption::GenerateKey();
$message = BeaconCommon::GenerateUUID();
$bf = BeaconEncryption::SymmetricEncrypt($key, $message, true);
$aes = BeaconEncryption::SymmetricEncrypt($key, $message, false);

header('Content-Type: text/plain');
echo 'TestEncryptionPortability("php", "' . base64_encode($key) . '", "' . $message . '", "' . base64_encode($bf) . '", "' . base64_encode($aes) . '")';

try {
	BeaconEncryption::SymmetricDecrypt($key, $bf);
} catch (Exception $err) {
	echo "\nFailed to decrypt blowfish: " . $err->getMessage();
}

try {
	BeaconEncryption::SymmetricDecrypt($key, $aes);
} catch (Exception $err) {
	echo "\nFailed to decrypt aes: " . $err->getMessage();
}

// from Beacon 1.4.8 and newer
TestEncryptionPortability("ciphermbs", "BO0qk2RScG2baup6WAYpiguTFpizGbDBbSx3gC/N/t0=", "eeff8a11-e5f8-4b78-ae69-dc12fc2675fd", "igFqWPg9U7pTJAAAACSo/43maibGAokDBTvNswpEF7/kiDTVZ1uRqRbSYqby3OhJ7AbuwcTwEzxZmg==", "igJD0Q/kz9v16/j0zZNR9yvRAAAAJKj/jeZRY5vTF6YiPmZZ2mN2z1CxVfyZqrxLcyVHprlpDbTa+yanYh4NltRkss+d476woTk=");

// from Beacon 1.4.7 and older
TestEncryptionPortability("m_crypto", "d91mxFHrUDwEdLM2vYr+Gm4TQh1gCKSbn2jMsVft9NA=", "0ccd9f2b-98f5-4f5e-be9a-d5fa34a891a7", "igHvE1aDgEeXlAAAACRDhoUOuVxa2Icn/LXcnVfqOC0Hx6s+8putqQwOCwsrxRc27X18sVv6ox09Xg==", "igKSVEqdy9MAQuU0V05WOsVkAAAAJEOGhQ7qB0FctVspKnkIcO3NVAN8GNGx7mG7/wAcfX/wDo+zDE95hFOvKcjh07co3LSZ7+U=");

function TestEncryptionPortability(string $source, string $key_encoded, string $message, string $legacy_encoded, string $modern_encoded) {
	$key = base64_decode($key_encoded);
	$legacy = base64_decode($legacy_encoded);
	$modern = base64_decode($modern_encoded);
	
	try {
		$decrypted = BeaconEncryption::SymmetricDecrypt($key, $legacy);
	} catch (Exception $err) {
		echo "\nUnable to decrypt blowfish from $source: " . $err->getMessage();
	}
	
	try {
		$decrypted = BeaconEncryption::SymmetricDecrypt($key, $modern);
	} catch (Exception $err) {
		echo "\nUnable to decrypt aes from $source: " . $err->getMessage();
	}
}

?>
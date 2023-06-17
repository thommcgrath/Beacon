<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$key = BeaconEncryption::GenerateKey(320);
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
TestEncryptionPortability("ciphermbs", "AcdHE85j+s4dB5bkTTlZ9Gha29AM7yS5Gs1ufTYvPI7Oktk0v8UoRg==", "b8398f3a-d824-46e6-a1dc-dce31683b1d3", "igFRTQGqO7BxzgAAACTzMx7Lv1LuEeD8wwdbG4vAY+t+FQEAwWAJGPZ4Srhx61dHIPfFiPC1LEn3fw==", "igKFXIhPpObtIp4prbDFhj7pAAAAJPMzHsvpGvB0jA6b0wCNMlCMhfmlpPgYpIRlV7t4ixXVEn8cBFBnEMV0P/S8A/q47MyE3OU=");
TestEncryptionPortability("ciphermbs-small-key", "sgBOp1B33B4=", "c5472ac4-59d9-4429-b349-e1ccece86155", "igGTGFXxw1wHkQAAACTH/ViBeidzRBVdicAnlGDyfc/wdJHYwa8Gj5hr1ff4FKV4TosZA6fHEDV1GA==", "igI1R6nZYfUE429NLDZitKyQAAAAJMf9WIHWVlPqyINEvL9FJCky/wbyg07vqcCqXmr8Zyi4J3CGOVZP4ML3GewKYQLnPw/Ddnk=");

// from Beacon 1.4.7 and older
TestEncryptionPortability("m_crypto", "Eq/Ypo2Kw3RNA2te31fp19EP/dMGSR4IlWmjtoYn8tBnKYgA+Sr2LA==", "3456efca-c48c-41cc-a01e-3713301d9a38", "igEeFJyHv42YOAAAACQTaroA7hSPqLmalHvZflHwhZtOiTYNUZD4JOdfusagXzlKt5PH2j8vUhxV0Q==", "igKh3O68LgyGZPABtA7OI0pzAAAAJBNqugBO2kDGdvIXrkfA5femIzmdRnDSSWI3xFA9diRZiHqdbbjH+qS/5Hi9Acjh26lGfmg=");

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

$cipher = 'bf-cbc';
$iv = base64_decode('79aMfVRxPw0=');
$key = base64_decode('2peenIoTK1k=');
$decrypted = openssl_decrypt(base64_decode('JBvDgbeC6vECJGiRnh27GQ=='), $cipher, $key, OPENSSL_RAW_DATA, $iv);

echo "Decrypted: {$decrypted}\n";

?>
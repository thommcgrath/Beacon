#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$curl = curl_init('https://github.com/passkeydeveloper/passkey-authenticator-aaguids/raw/refs/heads/main/combined_aaguid.json');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
$result = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

$parsed = json_decode($result, true);
if (count($parsed) === 0) {
	echo "Records not synced\n";
	exit;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
$idsToDelete = [];
$rows = $database->Query('SELECT authenticator_id FROM public.fido_names;');
while (!$rows->EOF()) {
	$idsToDelete[] = $rows->Field('authenticator_id');
	$rows->MoveNext();
}

foreach ($parsed as $uuid => $obj) {
	$name = $obj['name'];

	$idx = array_search($uuid, $idsToDelete);
	if ($idx !== false) {
		array_splice($idsToDelete, $idx, 1);
		$database->Query('UPDATE public.fido_names SET name = $2 WHERE authenticator_id = $1 AND name != $2;', $uuid, $name);
	} else {
		$database->Query('INSERT INTO public.fido_names (authenticator_id, name) VALUES ($1, $2);', $uuid, $name);
	}
}

foreach ($idsToDelete as $uuid) {
	$database->Query('DELETE FROM public.fido_names WHERE authenticator_id = $1;', $uuid);
}
$database->Commit();

echo "Records synced\n";

?>

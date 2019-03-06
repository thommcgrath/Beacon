<?php
require(dirname(__FILE__, 2) . '/framework/loader.php');

if (!isset($_GET['file_id'])) {
	echo "No file id";
	exit;
}

$file_id = $_GET['file_id'];
if (!BeaconCommon::IsUUID($file_id)) {
	echo "Not a UUID";
	exit;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT contents FROM corrupt_files WHERE file_id = $1;', $file_id);
if ($results->RecordCount() == 0) {
	echo "No such file";
	exit;
}

$contents = $results->Field('contents');
header('Content-Encoding: gzip');
header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="Bad Document.json"');

echo $contents;

?>
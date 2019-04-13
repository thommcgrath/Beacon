<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['id']) == false) {
	echo 'No image ID';
	http_response_code(400);
	exit;
}

$image_id = $_GET['id'];
if (BeaconCommon::IsUUID($image_id) == false) {
	echo 'Image ID is not a UUID';
	http_response_code(400);
	exit;
}

$scales = array('1');
if (isset($_GET['scale'])) {
	switch ($_GET['scale']) {
	case '3':
		array_unshift($scales, '2');
		array_unshift($scales, '3');
		break;
	case '2':
		array_unshift($scales, '2');
		break;
	}
}

foreach ($scales as $scale) {
	if (FindImage($image_id, $scale)) {
		exit;
	}
}

echo 'Image not found';
http_response_code(404);
exit;

function FindImage(string $image_id, string $scale) {
	$cache_key = $image_id . '@' . $scale . 'x';
	if ($scale != '1') {
		$data_column = 'image_data_' . $scale . 'x';
	} else {
		$data_column = 'image_data';
	}
	$cache_data = BeaconCache::Get($cache_key);
	if (!is_null($cache_data)) {
		header('Content-Type: ' . $cache_data['Content-Type']);
		http_response_code(200);
		echo $cache_data['Content'];
		return true;
	}
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT ' . $data_column . ', content_type FROM support_images WHERE image_id = $1 AND ' . $data_column . ' IS NOT NULL;', $image_id);
	if ($results->RecordCount() == 0) {
		return false;
	}
	
	$content_type = $results->Field('content_type');
	$content = $results->Field($data_column);
	
	BeaconCache::Set($cache_key, array('Content-Type' => $content_type, 'Content' => $content), 86400);
	
	header('Content-Type: ' . $content_type);
	http_response_code(200);
	
	echo $content;
	return true;
}

?>
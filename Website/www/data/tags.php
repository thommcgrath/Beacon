<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (empty($_GET['tag'])) {
	http_response_code(400);
	echo 'Missing tag parameter';
	exit;
}

$database = BeaconCommon::Database();
$results = $database->Query("SELECT build_number FROM updates WHERE stage >= 3 ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() == 1) {
	$build = intval($results->Field('build_number'));
} else {
	$build = 0;
}

$tag = $_GET['tag'];
$objects = BeaconBlueprint::GetWithTag($tag, $build);
if (count($objects) == 0) {
	echo '<h1>No Objects Tagged &quot;' . htmlentities(ucwords($tag)) . '&quot;</h1>';
	echo '<p>Sorry</p>';
	exit;
}

echo '<h1>Objects Tagged &quot;' . htmlentities(ucwords($tag)) . '&quot;</h1>';
echo '<ul>';
foreach ($objects as $object) {
	echo '<li><a href="/object/' . urlencode($object->ClassString()) . '">' . htmlentities($object->Label()) . '</a></li>';
}
echo '</ul>';

?>
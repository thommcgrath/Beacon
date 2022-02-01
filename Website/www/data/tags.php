<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (empty($_GET['tag'])) {
	http_response_code(400);
	echo 'Missing tag parameter';
	exit;
}

$tag = $_GET['tag'];
$objects = \Ark\Blueprint::GetWithTag($tag, BeaconCommon::MinVersion());
if (count($objects) == 0) {
	echo '<h1>No Objects Tagged &quot;' . htmlentities(ucwords($tag)) . '&quot;</h1>';
	echo '<p>Sorry</p>';
	exit;
}

echo '<h1>Objects Tagged &quot;' . htmlentities(ucwords($tag)) . '&quot;</h1>';
echo '<ul class="object_list">';
foreach ($objects as $object) {
	echo '<li><a href="/object/' . urlencode($object->ObjectID()) . '">' . htmlentities($object->Label()) . '</a></li>';
}
echo '</ul>';

?>
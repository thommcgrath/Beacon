<?php

if (empty($_REQUEST['document_id'])) {
	header('Location: /browse/');
	exit;
}

require(dirname(__FILE__, 3) . '/framework/loader.php');

$project_id = $_REQUEST['document_id'];
$search_keys = array(
	'public' => true,
	'document_id' => $project_id
);

$projects = \Ark\Project::Search($search_keys);
if (count($projects) != 1) {
	http_response_code(404);
	BeaconTemplate::SetTitle('Document Not Found');
	echo '<h1>Document not found</h1><p><a href="/browse/">Browse community documents</a></p>';
	exit;
}

$project = $projects[0];

$generator = new \Ark\Generator($project);
if (array_key_exists('quality_scale', $_REQUEST)) {
	$generator->SetQualityScale(floatval($_REQUEST['quality_scale']));
}
if (array_key_exists('difficulty_value', $_REQUEST)) {
	$generator->SetDifficultyValue(floatval($_REQUEST['difficulty_value']));
}
if (array_key_exists('map_mask', $_REQUEST)) {
	$generator->SetMapMask(intval($_REQUEST['map_mask']));
}

$original_ini = '';
if (isset($_FILES['content'])) {
	if (is_uploaded_file($_FILES['content']['tmp_name'])) {
		$original_ini = file_get_contents($_FILES['content']['tmp_name']);
	}
} elseif (isset($_POST['content'])) {
	$original_ini = $_POST['content'];
}

$output = $generator->Generate($original_ini);

$mode = isset($_REQUEST['mode']) ? $_REQUEST['mode'] : 'inline';

if ($mode === 'download') {
	http_response_code(200);
	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="Game.ini"');
	header('Content-MD5: ' . md5($output));
	ob_clean();
	echo $output;
	exit;
}

BeaconTemplate::AddScript(BeaconCommon::AssetURI('clipboard-polyfill.js'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('generator.js'));

?><h1>Your Game.ini</h1>
<p class="text-center"><button id="copy_button">Copy</button></p>
<p><textarea readonly rows="20" wrap="off" id="content_output"><?php echo $output; ?></textarea></p>
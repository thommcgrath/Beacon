<?php

if (empty($_REQUEST['projectId'])) {
	header('Location: /browse/');
	exit;
}

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Project;
use BeaconAPI\v4\Ark\Generator;

$projectId = $_REQUEST['projectId'];
$project = Project::Fetch($projectId);
if (is_null($project) || $project->IsPublic() === false) {
	http_response_code(404);
	BeaconTemplate::SetTitle('Project Not Found');
	echo '<h1>Project not found</h1><p><a href="/browse/">Browse community projects</a></p>';
	exit;
}

$generator = new Generator($project);
if (array_key_exists('qualityScale', $_REQUEST)) {
	$generator->SetQualityScale(floatval($_REQUEST['qualityScale']));
}
if (array_key_exists('difficultyValue', $_REQUEST)) {
	$generator->SetDifficultyValue(floatval($_REQUEST['difficultyValue']));
}
if (array_key_exists('mapMask', $_REQUEST)) {
	$generator->SetMapMask(intval($_REQUEST['mapMask']));
}

$originalIni = '';
if (isset($_FILES['content'])) {
	if (is_uploaded_file($_FILES['content']['tmp_name'])) {
		$originalIni = file_get_contents($_FILES['content']['tmp_name']);
	}
} elseif (isset($_POST['content'])) {
	$originalIni = $_POST['content'];
}

$output = $generator->Generate($originalIni);
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

BeaconTemplate::AddScript(BeaconCommon::AssetURI('generator.js'));

?><h1>Your Game.ini</h1>
<p class="text-center"><button id="copy_button">Copy</button></p>
<p><textarea readonly rows="20" wrap="off" id="content_output"><?php echo $output; ?></textarea></p>
<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['slug']) == false) {
	echo 'No video specified';
	http_response_code(400);
	exit;
}

BeaconTemplate::StartStyles(); ?>
<style>

.embedded_youtube_video {
	position: relative;
	padding-bottom: 56.25%;
	padding-top: 30px;
	height: 0;
	overflow: hidden;
}

.embedded_youtube_video iframe, .embedded_youtube_video object, .embedded_youtube_video embed {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

</style>
<?php
BeaconTemplate::FinishStyles();

$slug = $_GET['slug'];
$database = BeaconCommon::Database();

$results = $database->Query('SELECT host, host_video_id FROM support_videos WHERE video_slug = $1;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}

switch ($results->Field('host')) {
case 'YouTube':
	echo '<div class="embedded_youtube_video"><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/' . $results->Field('host_video_id') . '" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>';
	break;
}

?>
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

$results = $database->Query('SELECT video_title, host, host_video_id FROM support_videos WHERE video_slug = $1;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}

echo '<h1>' . htmlentities($results->Field('video_title')) . '</h1>';

switch ($results->Field('host')) {
case 'YouTube':
	echo '<div class="embedded_youtube_video"><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/' . $results->Field('host_video_id') . '" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>';
	break;
case 'Vimeo':
	echo '<div class="embedded_youtube_video"><iframe src="https://player.vimeo.com/video/' . $results->Field('host_video_id') . '" width="640" height="564" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe></div>';
	break;
}

?>
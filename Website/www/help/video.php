<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['slug']) == false) {
	echo 'No video specified';
	http_response_code(400);
	exit;
}

$slug = $_GET['slug'];
$database = BeaconCommon::Database();

$results = $database->Query('SELECT video_title, host, host_video_id FROM support_videos WHERE video_slug = $1;', $slug);
if ($results->RecordCount() == 0) {
	echo 'Article not found';
	http_response_code(404);
	exit;
}

echo '<h1>' . htmlentities($results->Field('video_title')) . '</h1>';
BeaconTemplate::SetTitle($results->Field('video_title'));

$video_link = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];

BeaconTemplate::StartScript(); ?>
<script>
const beacon = {
	h264Tested: false,
	h264Supported: undefined,
	testH264: function() {
		if (this.h264Tested) {
			return;
		}
		
		const testPlayer = document.createElement( "video" );
		if (testPlayer.canPlayType) {
			this.h264Supported = Boolean(testPlayer.canPlayType('video/mp4; codecs="avc1.42C01E"'));
		}
		this.h264Tested = true;
	},
	pageLoaded: function(buildNumber) {
		this.testH264();
		
		if (!this.h264Supported) {
			executeInXojo('openInBrowser', <?php echo json_encode($video_link); ?>);
		}
	}
};

window.addEventListener('DOMContentLoaded', (event) => {
	beacon.testH264();
	
	if (!beacon.h264Supported) {
		const warning = document.getElementById('playback-warning');
		warning.classList.remove('hidden');
	}
	
	const copyLinkButton = document.getElementById('copy-video-link');
	if (copyLinkButton) {
		copyLinkButton.addEventListener('click', (event) => {
			event.preventDefault();
			navigator.clipboard.writeText(<?php echo json_encode($video_link); ?>);
			event.target.innerText = 'Link Copied';
			return false;
		});
	}
});
</script>
<?php
BeaconTemplate::FinishScript();
	
echo '<div class="notice-block notice-warning text-center hidden" id="playback-warning">If you experience playback problems, visit ' . $video_link . ' with your browser. <a href="#" id="copy-video-link">Copy Link</a></div>';

switch ($results->Field('host')) {
case 'YouTube':
	echo '<div class="embedded_youtube_video"><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/' . $results->Field('host_video_id') . '" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>';
	break;
case 'Vimeo':
	echo '<div class="embedded_youtube_video"><iframe src="https://player.vimeo.com/video/' . $results->Field('host_video_id') . '" width="640" height="564" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe></div>';
	break;
}

?>
<?php

$original_version = intval($_GET['from']);
$current_version = intval($_GET['to']);
$pages = [];

function StartPage(string $title) {
	ob_start();
	echo '<div id="' . bin2hex(random_bytes(6)) . '" class="page" beacon-title="' . htmlentities($title) . '">';
}

function EndPage() {
	global $pages;
	echo '</div>';
	$content = ob_get_contents();
	ob_end_clean();
	$pages[] = $content;
}

if ($original_version < 1) {
	StartPage('Welcome to Beacon');
	echo 'This is a work in progress. For now, <a href="/videos/introduction_to_loot_drops_with">watch this video</a> to learn about Beacon.';
	EndPage();
} else {
	if ($current_version >= 10500000 && $original_version < 10500000) {
		StartPage('What\'s new in Beacon 1.5');
		echo '<p>This is a work in progress. For now, <a href="/videos/whats_new_in_beacon_15">watch this video</a> for new features.</p><p>Since that video was produced, Beacon has added a Decay and Spoil editor, new breeding multipliers options, and password management in the Servers editor.</p>';
		EndPage();
	}
}

if (count($pages) === 0) {
	// Nothing new
	http_response_code(302);
	header('Location: beacon://finished');
	exit;
}

?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>Welcome to Beacon</title>
		<script>
		var original_version = <?php echo json_encode($original_version); ?>;
		var current_version = <?php echo json_encode($current_version); ?>;
		</script>
		<script src="index.js"></script>
		<link href="/assets/css/normalize.css" rel="stylesheet">
		<link href="https://use.typekit.net/paa2qqa.css" rel="stylesheet">
		<link href="index.css" rel="stylesheet">
	</head>
	<body>
		<div id="main_wrapper">
			<?php
			echo implode("\n", $pages);
			?>
			<div id="navigator">
				<div id="navigator_left"><button id="skip_button">Skip</button></div>
				<div id="navigator_center"><div id="navigator_pips"><?php if (count($pages) > 1) { echo str_repeat('<div class="pip">&nbsp;</div>', count($pages)); } ?></div></div>
				<div id="navigator_right"><button id="previous_button" disabled>Back</button><button id="next_button">Next</button></div>
			</div>
		</div>
	</body>
</html>
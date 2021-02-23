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
	echo '<div class="duo duo-left"><div class="duo-image"><a href="/videos/welcome_to_beacon" target="_blank"><img src="beacon15-video-thumb.png" width="298" height="167" alt="Welcome to Beacon Video"></a></div><div class="duo-text"><h1>Welcome to Beacon</h1><p>To help you get started with Beacon, you should watch this introduction video. You\'ll be shown how to navigate a Beacon project, create loot drops, update servers, and use config sets. It will 20 minutes well spent.</p></div></div>';
	EndPage();
} else {
	if ($current_version >= 10500000 && $original_version < 10500000) {
		StartPage('New Look');
		echo '<div class="duo duo-left"><div class="duo-image"><img src="beacon15-new-design.png" width="298" height="186" alt=""></div><div class="duo-text"><h1>Updated Design</h1><p>Beacon has grown a lot since the last time its layout was updated, and there is a lot more going on these days. The new design is faster to use, easier to discover, and more consistent.</p></div></div>';
		EndPage();
		
		StartPage('Config Sets');
		echo '<div class="duo duo-right"><div class="duo-image"><img src="beacon15-config-sets-menu.png" width="298" height="242" alt=""></div><div class="duo-text"><h1>Introducing Config Sets</h1><p>Config sets are one of the most powerful features ever introduced to Beacon. Now you can setup small batches of changes that can be quickly applied to servers, such as enabling PvP on weekends or running a breeding event. For admins of multiple servers, config sets allow servers to share common settings, while maintaining differences that make them unique.</p></div></div>';
		EndPage();
		
		StartPage('Decay and Spoil Editor');
		echo '<div class="duo duo-left"><div class="duo-image"><img src="beacon15-decay-spoil.png" width="298" height="195" alt=""></div><div class="duo-text"><h1>Decay and Spoil Editor</h1><p>The new Decay and Spoil editor allows easy control of structure decay and destruction, as well as spoil times, all with a nice chart to preview the effects. This new editor is free for all Beacon users.</div></div>';
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
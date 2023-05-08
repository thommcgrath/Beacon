<?php

$original_version = intval($_GET['from']);
$current_version = intval($_GET['to']);
$platform = isset($_GET['platform']) ? $_GET['platform'] : 'any';
$show_latest = ($original_version > $current_version); // this means show the latest	
$pages = [];
$page_direction = 'left';

function StartPage(string $title) {
	ob_start();
	echo '<div id="' . bin2hex(random_bytes(6)) . '" class="page" beacon-title="' . htmlentities($title) . '">';
}

function EndPage() {
	global $pages, $page_direction;
	echo '</div>';
	$content = ob_get_contents();
	ob_end_clean();
	$pages[] = $content;
	if ($page_direction === 'left') {
		$page_direction = 'right';
	} else {
		$page_direction = 'left';
	}
}

if ($original_version < 1) {
	StartPage('Welcome to Beacon');
	echo '<div class="duo duo-left"><div class="duo-image"><a href="/videos/welcome_to_beacon" target="_blank"><img src="beacon15-video-thumb.png" width="298" height="167" alt="Welcome to Beacon Video"></a></div><div class="duo-text"><h1>Welcome to Beacon</h1><p>To help you get started with Beacon, you should watch this introduction video. You\'ll be shown how to navigate a Beacon project, create loot drops, update servers, and use config sets. It will be 20 minutes well spent.</p></div></div>';
	EndPage();
} else {
	if ($current_version >= 10500000 && $original_version < 10500000) {
		StartPage('New Look');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon15-new-design.png" width="298" height="186" alt=""></div><div class="duo-text"><h1>Updated Design</h1><p>Beacon has grown a lot since the last time its layout was updated, and there is a lot more going on these days. The new design is faster to use, easier to discover, and more consistent.</p></div></div>';
		EndPage();
		
		StartPage('Config Sets');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon15-config-sets-menu.png" width="298" height="242" alt=""></div><div class="duo-text"><h1>Introducing Config Sets</h1><p>Config sets are one of the most powerful features ever introduced to Beacon. Now you can setup small batches of changes that can be quickly applied to servers, such as enabling PvP on weekends or running a breeding event. For admins of multiple servers, config sets allow servers to share common settings, while maintaining differences that make them unique.</p></div></div>';
		EndPage();
		
		StartPage('Decay and Spoil Editor');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon15-decay-spoil.png" width="298" height="195" alt=""></div><div class="duo-text"><h1>Decay and Spoil Editor</h1><p>The new Decay and Spoil editor allows easy control of structure decay and destruction, as well as spoil times, all with a nice chart to preview the effects. This new editor is free for all Beacon users.</div></div>';
		EndPage();
	}
	if ($current_version >= 10501000 && $original_version < 10501000 && $original_version >= 10500000) {
		StartPage('Import Into Config Sets');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon151-import.png" width="298" height="194" alt=""></div><div class="duo-text"><h1>Import Into Config Sets</h1><p>The import results window now allows you to select (or create) config sets to import individual config pieces into.</p></div></div>';
		EndPage();
	}
	if ($current_version >= 10501000 && $original_version < 10501000) {
		StartPage('Creature Colors');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon151-colors.png" width="298" height="70" alt=""></div><div class="duo-text"><h1>Change Creature Colors</h1><p>You can now choose different color sets for your spawn overrides. That means you can have rainbow dinosaurs without running an event!</p></div></div>';
		EndPage();
		
		StartPage('Breeding Multiplier Profiles');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon151-breeding.png" width="298" height="274" alt=""></div><div class="duo-text"><h1>Breeding Multiplier Profiles</h1><p>Ever needed to compute breeding multipliers for single player or while an event was running? Beacon can now adjust its math to accomodate these situations.</p></div></div>';
		EndPage();
		
		StartPage('New Hosting Provider');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon151-gameserverapp.png" width="298" height="130" alt=""></div><div class="duo-text"><h1>GameServerApp.com Integration</h1><p>Beacon can now automatically import and update your GameServerApp.com config templates!</p></div></div>';
		EndPage();
	}
	if ($show_latest || ($current_version >= 10600000 && $original_version < 10600000)) {
		if ($platform === 'windows') {
			StartPage('Dark Mode Support');
			echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon16-windows-dark.png" width="298" height="186" alt=""></div><div class="duo-text"><h1>Dark Mode Support</h1><p>For users on Windows 10 and 11, Beacon will follow the colors chosen in system settings.</p></div></div>';
			EndPage();
		}
		
		StartPage('Loot Defaults');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon16-loot-defaults.png" width="298" height="186" alt=""></div><div class="duo-text"><h1>Loot Defaults</h1><p>Beacon now knows the default loot drop contents for nearly every drop Beacon supports.</p></div></div>';
		EndPage();
		
		StartPage('New Code Editor');
		echo '<div class="duo duo-' . $page_direction . '"><div class="duo-image"><img src="beacon16-code-editor.png" width="298" height="186" alt=""></div><div class="duo-text"><h1>New Code Editor</h1><p>Based on Scintilla, the same text engine that runs Notepad++, Beacon\'s code fields now support syntax coloring, autocomplete, and better performance.</p></div></div>';
		EndPage();
	}
}

if (count($pages) === 0) {
	// Nothing new
	http_response_code(302);
	header('Location: beacon://finished');
	exit;
}

$nonce = base64_encode(random_bytes(12));
header("Content-Security-Policy: default-src 'self'; script-src 'self' 'nonce-{$nonce}'");

?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>Welcome to Beacon</title>
		<script nonce="<?php echo $nonce; ?>">
		var original_version = <?php echo json_encode($original_version); ?>;
		var current_version = <?php echo json_encode($current_version); ?>;
		</script>
		<script src="/assets/scripts/build/whatsnew.js"></script>
		<link href="/assets/css/build/whatsnew.css" rel="stylesheet">
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

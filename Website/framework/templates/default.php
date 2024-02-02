<?php

if (!BeaconTemplate::IsHTML()) {
	echo $buffer;
	exit;
}

$description = BeaconTemplate::PageDescription();

$body_class = BeaconTemplate::BodyClass();

$css_folder = dirname(__FILE__, 3) . '/www/assets/css/';
if ($body_class === '') {
	$theme = 'beacon';
} else {
	$theme = $body_class;
}
$theme_files = [];
if (file_exists($css_folder . "theme-{$theme}.css")) {
	$theme_files[''] = "theme-{$theme}.css";
}
if (file_exists($css_folder . "theme-{$theme}-dark.css")) {
	$theme_files['(prefers-color-scheme: dark)'] = "theme-{$theme}-dark.css";
}

$theme_colors = [];
if ($body_class === 'purple') {
	$theme_colors[''] = '#9c0fb0';
} else {
	$theme_colors['(prefers-color-scheme: light)'] = '#ffffff';
	$theme_colors['(prefers-color-scheme: dark)'] = '#262626';
}

$noNavigation = BeaconTemplate::GetVar('No Navigation') === true;

?><!DOCTYPE html>
<html lang="en" prefix="og: http://ogp.me/ns#">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, viewport-fit=cover">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="icon" type="image/png" sizes="32x32" href="<?php echo BeaconCommon::AssetURI('favicon-32x32.png'); ?>">
		<link rel="icon" type="image/png" sizes="16x16" href="<?php echo BeaconCommon::AssetURI('favicon-16x16.png'); ?>">
		<link rel="mask-icon" href="<?php echo BeaconCommon::AssetURI('safari-pinned-tab.svg'); ?>" color="#9c0fb0">
		<link rel="shortcut icon" href="<?php echo BeaconCommon::AssetURI('favicon.ico'); ?>">
		<link rel="apple-touch-icon" href="<?php echo BeaconCommon::AssetURI('apple-touch-icon.png'); ?>">
		<link rel="alternate" type="application/json" title="Beacon Developer Blog" href="/blog/json.php">
		<link rel="alternate" type="application/rss+xml" title="Beacon Developer Blog" href="/blog/rss.php">
		<meta name="msapplication-config" content="<?php echo BeaconCommon::AssetURI('browserconfig.xml'); ?>">
		<?php
		foreach ($theme_colors as $media => $color) {
			if (empty($media)) {
				echo "<meta name=\"theme-color\" content=\"{$color}\">\n\t\t";
			} else {
				echo "<meta name=\"theme-color\" media=\"{$media}\" content=\"{$color}\">\n\t\t";
			}
		}
		foreach ($theme_files as $media => $asset) {
			if (empty($media)) {
				echo '<link href="' . BeaconCommon::AssetURI($asset) . '" rel="stylesheet" type="text/css">';
			} else {
				echo '<link href="' . BeaconCommon::AssetURI($asset) . '" media="' . $media . '" rel="stylesheet" type="text/css">';
			}
		}
		?><meta name="x-beacon-health" content="5ce75a54-428c-4f4c-a0a9-b73c868dc9e7">
		<script src="<?php echo BeaconCommon::AssetURI('default.js'); ?>"></script>
		<?php
		$header_lines = BeaconTemplate::ExtraHeaderLines();
		for ($i = 0; $i < count($header_lines); $i++) {
			$line = $header_lines[$i];
			if ($i == 0) {
				echo "$line\n";
			} else {
				echo "\t\t$line\n";
			}
			unset($line);
		}
		unset($header_lines);
		?>
	</head>
	<body<?php if ($noNavigation) { echo ' class="no-navigation"'; } ?>>
		<div id="header_wrapper">
			<div id="header" class="pagebody">
				<div id="header_logo_cell"><a href="/"><img id="header_logo" src="<?php echo BeaconCommon::AssetURI('beacon-header-color.svg'); ?>" height="80" alt="Beacon for Ark: Survival Evolved"></a></div>
				<div id="header_links_cell"><ul><li><a id="menu_explore_link" href="#">Explore</a></li><li><a id="menu_download_link" href="/download">Download</a></li><li><a id="menu_support_link" href="/help/">Help</a></li><li><a id="menu_buy_link" href="/omni">Buy</a></li></ul></div>
			</div>
		</div>
		<div id="content_wrapper">
			<div id="content" class="pagebody">
				<?php echo $buffer; ?>
			</div>
			<div id="footer" class="pagebody">
				<p>Beacon is an open source project by</p>
				<p><a class="external_logo" href="https://thezaz.com/"><img class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('thezaz-color.svg'); ?>" height="120" alt="The ZAZ Studios"></a></p>
				<p>Copyright 2016-<?php echo date('Y'); ?></p>
				<p><a class="external_logo" href="https://github.com/thommcgrath/Beacon" title="GitHub"><img height="24" class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('github-color.svg'); ?>" alt="Beacon on GitHub"></a><a class="external_logo" href="/discord" title="Discord"><img height="24" class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('discord-color.svg'); ?>" alt="Beacon Discord Server"></a></p>
				<p>Get in touch using <a href="/help/contact">our support form</a>.<span class="smaller"><br><a href="/policies/privacy">Privacy Policy</a></span></p>
			</div>
		</div>
		<div id="explore_container">
			<div id="explore_popover">
				<div><input id="explore_search_field" type="search" placeholder="Search" incremental></div>
				<ul id="explore_links">
					<li><a href="/videos/welcome_to_beacon">Video: Welcome to Beacon</a></li>
					<li><a href="/Games">Supported Games</a></li>
					<li><a href="/browse/">Browse Community Projects</a></li>
					<li><a href="/account/">Beacon Account</a></li>
					<li><a href="/blog/">Development Blog</a></li>
				</ul>
				<div id="explore_results">
					<ul id="explore_results_list"></ul>
					<div id="explore_results_empty">No Results</div>
					<div id="explore_results_buttons">
						<div id="explore_results_left_button"><button id="explore_results_back">Back</button></div>
						<div id="explore_results_right_button"><button id="explore_results_more">More</button></div>
					</div>
				</div>
			</div>
		</div>
		<div id="overlay"></div>
		<div id="dialog">
			<div id="dialog_inner">
				<p id="dialog_message">Message</p>
				<p id="dialog_explanation">Explanation</p>
				<p id="dialog_buttons"><button id="dialog_cancel_button">Cancel</button><button id="dialog_action_button" class="default">Ok</button></p>
			</div>
		</div>
		<?php

		$modals = BeaconTemplate::Modals();
		foreach ($modals as $modal_id) {
			$modal_content = BeaconTemplate::ModalContent($modal_id);
			echo '<div id="' . $modal_id . '" class="modal">' . $modal_content . '</div>';
		}

		?>
	</body>
</html>

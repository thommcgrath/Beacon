<?php

if (!BeaconTemplate::IsHTML()) {
	echo $buffer;
	exit;
}

$description = BeaconTemplate::PageDescription();
if (empty($description)) {
	$description = "Beacon is Ark's easiest server manager that can update and control your Xbox, PS4, and PC Ark servers with a couple clicks.";
}

?><!DOCTYPE html>
<html<?php if (BeaconTemplate::BodyClass() != '') { echo ' class="' . BeaconTemplate::BodyClass() . '"'; } ?>>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="<?php echo htmlentities($description); ?>">
		<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicon/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon/favicon-16x16.png">
		<link rel="manifest" href="/assets/favicon/manifest.json">
		<link rel="mask-icon" href="/assets/favicon/safari-pinned-tab.svg" color="#713a9a">
		<link rel="shortcut icon" href="/assets/favicon/favicon.ico">
		<link rel="alternate" type="application/json" title="Beacon Developer Blog" href="/blog/json.php">
		<link rel="alternate" type="application/rss+xml" title="Beacon Developer Blog" href="/blog/rss.php">
		<link rel="search" type="application/opensearchdescription+xml" href="/search/opensearch.php" title="Beacon Search">
		<meta name="apple-mobile-web-app-title" content="Beacon">
		<meta name="application-name" content="Beacon">
		<meta name="msapplication-config" content="/assets/favicon/browserconfig.xml">
		<meta name="theme-color" content="#713a9a">
		<link href="<?php echo BeaconCommon::AssetURI('default.scss'); ?>" rel="stylesheet" type="text/css">
		<link href="<?php echo BeaconCommon::AssetURI('colors.scss'); ?>" rel="stylesheet" type="text/css">
		<script src="<?php echo BeaconCommon::AssetURI('common.js'); ?>"></script>
		<script src="<?php echo BeaconCommon::AssetURI('default.js'); ?>"></script>
		<title><?php echo htmlentities(BeaconTemplate::Title()); ?></title>
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
	<body>
		<div id="header_wrapper">
			<div id="header" class="pagebody">
				<div id="header_logo_cell"><a href="/"><img id="header_logo" src="<?php echo BeaconCommon::AssetURI('beacon-header-color.svg'); ?>" height="80"></a></div>
				<div id="header_links_cell"><ul><li><a id="menu_explore_link" href="#">Explore</a></li><li><a id="menu_download_link" href="/download/">Download</a></li><li><a id="menu_support_link" href="/help/">Support</a></li><li><a id="menu_buy_link" href="/omni/">Buy</a></li></ul></div>
			</div>
		</div>
		<div id="content_wrapper">
			<div id="content" class="pagebody">
				<?php echo $buffer; ?>
			</div>
			<div id="footer" class="pagebody">
				<p>Beacon is an open source project by</p>
				<p><a class="external_logo" href="https://thezaz.com/"><img class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('thezaz-color.svg'); ?>" height="120"></a></p>
				<p>Copyright 2016-<?php echo date('Y'); ?></p>
				<p><a class="external_logo" href="https://github.com/thommcgrath/Beacon" title="GitHub"><img height="24" class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('github-color.svg'); ?>"></a><a class="external_logo" href="/discord.php" title="Discord"><img height="24" class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('discord-color.svg'); ?>"></a></p>
				<p>Get in touch using <a href="/help/contact">our support form</a>.<span class="smaller"><br><a href="/help/about_user_privacy">Privacy Policy</a></span></p>
			</div>
		</div>
		<div id="explore_container">
			<div id="explore_popover">
				<div><input id="explore_search_field" type="search" placeholder="Search" incremental></div>
				<ul id="explore_links">
					<li><a href="/videos/introduction_to_loot_drops_with">Video: Introduction to Beacon</a></li>
					<li><a href="/browse/">Browse Community Files</a></li>
					<li><a href="/spawn/">Admin Spawn Codes</a></li>
					<li><a href="/mods/">Supported Mods</a></li>
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
		<?php BeaconTemplate::PhotoSwipeDOM(); ?>
	</body>
</html>
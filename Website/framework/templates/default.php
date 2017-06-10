<?php

if (!BeaconTemplate::IsHTML()) {
	echo $buffer;
	exit;
}

?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><?php echo htmlentities(BeaconTemplate::Title()); ?></title>
		<link href="/assets/css/main.css" rel="stylesheet" media="all" type="text/css">
		<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicon/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon/favicon-16x16.png">
		<link rel="manifest" href="/assets/favicon/manifest.json">
		<link rel="mask-icon" href="/assets/favicon/safari-pinned-tab.svg" color="#713a9a">
		<link rel="shortcut icon" href="/assets/favicon/favicon.ico">
		<meta name="apple-mobile-web-app-title" content="Beacon">
		<meta name="application-name" content="Beacon">
		<meta name="msapplication-config" content="/assets/favicon/browserconfig.xml">
		<meta name="theme-color" content="#713a9a">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<header>
			<div class="inner">
				<a href="/" id="header_link"><img id="header_logo_small" width="40" height="40" src="/assets/images/beacon-color.svg"><img id="header_logo_full" width="256" height="40" src="/assets/images/header.svg"></a>
				<div id="top-menu">
					<a href="/spawn/">Spawn Codes</a>
					<a href="/help/">Help</a>
					<a href="/download/">Download</a>
				</div>
			</div>
		</header>
		<main class="inner">
			<?php echo $buffer; ?>
		</main>
		<footer class="inner">
			<p><a id="footer_github_logo" href="https://github.com/thommcgrath/Beacon"><img height="24" src="/assets/images/github.svg"></a><a id="footer_patreon_logo" href="https://www.patreon.com/thommcgrath"><img height="24" src="/assets/images/patreon-white.svg"></a><a id="footer_discord_logo" href="https://discord.gg/2vbT7fV"><img height="24" src="/assets/images/discord-white.svg"></a></p>
			<p>Beacon is an open source project by Thom McGrath. Copyright 2016-<?php echo date('Y'); ?>.</p>
			<p>Get in touch using <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
		</footer>
	</body>
</html>
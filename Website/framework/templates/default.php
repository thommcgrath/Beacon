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
			<div id="top-menu">
				<a href="/spawn/">Spawn Codes</a>
				<a href="/help/">Help</a>
				<a href="/download/">Download</a>
			</div>
		</header>
		<main>
			<?php echo $buffer; ?>
		</main>
		<footer>
			<p><a id="footer_github_logo" href="https://github.com/thommcgrath/Beacon"><img width="96" height="26" src="/assets/images/github.svg"></a></p>
			<p>Beacon is an open source project by Thom McGrath. Copyright 2016-<?php echo date('Y'); ?>.</p>
			<p>Get in touch using <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
		</footer>
	</body>
</html>
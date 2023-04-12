<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Welcome to Beacon</title>
		<meta name="viewport" content="width=400">
		<script type="text/javascript" nonce="<?php echo $_SERVER['CSP_NONCE']; ?>">var login_only = <?php echo (empty($_GET['login_only']) == false && boolval($_GET['login_only']) == true) ? 'true' : 'false'; ?>;</script>
		<link href="<?php echo BeaconCommon::AssetURI('build/theme-beacon.css'); ?>" rel="stylesheet" type="text/css">
		<link href="<?php echo BeaconCommon::AssetURI('build/welcome.css'); ?>" rel="stylesheet" media="all" type="text/css">
		<script src="<?php echo BeaconCommon::AssetURI('common.js'); ?>"></script>
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
		<?php echo $buffer; ?>
		<div id="overlay"></div>
		<div id="dialog">
			<div id="dialog_inner">
				<p id="dialog_message">Message</p>
				<p id="dialog_explanation">Explanation</p>
				<p id="dialog_buttons"><button id="dialog_cancel_button">Cancel</button><button id="dialog_action_button" class="default">Ok</button></p>
			</div>
		</div>
	</body>
</html>
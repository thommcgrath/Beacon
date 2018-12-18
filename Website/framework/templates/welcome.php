<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Welcome to Beacon</title>
		<meta name="viewport" content="width=400">
		<script type="text/javascript" nonce="<?php echo $_SERVER['CSP_NONCE']; ?>">var login_only = <?php echo (empty($_GET['login_only']) == false && boolval($_GET['login_only']) == true) ? 'true' : 'false'; ?>;</script>
		<link href="<?php echo BeaconCommon::AssetURI('default.scss'); ?>" rel="stylesheet" type="text/css">
		<link href="<?php echo BeaconCommon::AssetURI('colors.scss'); ?>" rel="stylesheet" type="text/css">
		<link href="<?php echo BeaconCommon::AssetURI('welcome.scss'); ?>" rel="stylesheet" media="all" type="text/css">
		<script src="<?php echo BeaconCommon::AssetURI('common.js'); ?>"></script>
		<script src="<?php echo BeaconCommon::AssetURI('welcome.js'); ?>"></script>
	</head>
	<body>
		<?php echo $buffer; ?>
	</body>
</html>
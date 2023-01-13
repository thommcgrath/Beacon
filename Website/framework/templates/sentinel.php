<?php

if (!BeaconTemplate::IsHTML()) {
	echo $buffer;
	exit;
}

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	echo 'Unauthorized';
	exit;
}
$session->Renew();
$user = BeaconUser::GetByUserID($session->UserID());

$description = BeaconTemplate::PageDescription();
$sprites = BeaconCommon::AssetURI('sentinel-icons.svg');

$sidebar_items = [
	[
		'url' => '/account/sentinel/',
		'caption' => 'Dashboard',
		'icon' => 'meter2'
	],
	[
		'url' => '/account/sentinel/servers/',
		'caption' => 'Servers',
		'icon' => 'drive'
	],
	[
		'url' => '/account/sentinel/players/',
		'caption' => 'Players',
		'icon' => 'users'
	]
];

?><!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<?php if (!empty($description)) { ?><meta name="description" content="<?php echo htmlentities($description); ?>">
		<?php } ?><link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon/favicon-16x16.png">
		<link rel="manifest" href="/assets/favicon/manifest.json">
		<link rel="mask-icon" href="/assets/favicon/safari-pinned-tab.svg" color="#9c0fb0">
		<link rel="shortcut icon" href="/assets/favicon/favicon.ico">
		<link rel="alternate" type="application/json" title="Beacon Developer Blog" href="/blog/json.php">
		<link rel="alternate" type="application/rss+xml" title="Beacon Developer Blog" href="/blog/rss.php">
		<meta name="apple-mobile-web-app-title" content="Beacon">
		<meta name="application-name" content="Beacon">
		<meta name="msapplication-config" content="/assets/favicon/browserconfig.xml">
		<meta name="theme-color" content="#9c0fb0">
		<meta name="x-beacon-health" content="5ce75a54-428c-4f4c-a0a9-b73c868dc9e7">
		<link href="<?php echo BeaconCommon::AssetURI('sentinel.scss'); ?>" rel="stylesheet" type="text/css">
		<script nonce="<?php echo htmlentities($_SERVER['CSP_NONCE']); ?>">
		window.browserSupported = false;
		</script>
		<script src="<?php echo BeaconCommon::AssetURI('common.js'); ?>"></script>
		<script src="<?php echo BeaconCommon::AssetURI('sentinel-core.js'); ?>"></script>
		<script nonce="<?php echo htmlentities($_SERVER['CSP_NONCE']); ?>">
		document.addEventListener('DOMContentLoaded', () => {
			SentinelCommon.init(<?php echo json_encode($session->SessionID()); ?>, <?php echo json_encode(BeaconCommon::APIDomain()); ?>);
		});
		</script>
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
		<script nonce="<?php echo htmlentities($_SERVER['CSP_NONCE']); ?>">
		if (window.browserSupported === false) {
			//window.location = <?php echo json_encode(BeaconCommon::AbsoluteURL('/sentinel/browser-test')); ?>;
		}
		</script>
	</head>
	<body>
		<div id="header">
			<div id="header-menu-cell"><a href="#" id="menu-button"><div class="menu-button-line"></div><div class="menu-button-line"></div><div class="menu-button-line"></div></a></div>
			<div id="header-logo-cell"><a href="/account/sentinel/"><picture>
					<source srcset="<?php echo BeaconCommon::AssetURI('beacon-logomark-dark.svg'); ?>" media="(prefers-color-scheme: dark)">
					<img id="header-logo" src="<?php echo BeaconCommon::AssetURI('beacon-logomark.svg'); ?>">
				</picture></a></div>
			<div id="header-accessory-cell">Accessory</div>
			<div id="header-user-cell">
				<div id="header-user-button">
					<div class="usericon">
						<svg viewBox="0 0 24 24"><use xlink:href="<?php echo htmlentities($sprites . '#icon-users'); ?>"></use></svg>
					</div>
					<div class="username">
						<?php echo htmlentities($user->Username()); ?><span class="user-suffix"><?php echo htmlentities('#' . $user->Suffix()); ?></span>
					</div>
				</div>
			</div>
		</div>
		<div id="main-wrapper">
			<div id="main-sidebar">
				<ul>
					<?php
					
					foreach ($sidebar_items as $item) {
						echo '<li';
						if (BeaconTemplate::GetVar('Sentinel Sidebar Highlight') === $item['caption']) {
							echo ' class="active"';
						}
						echo '><a href="' . htmlentities($item['url']) . '"><svg viewBox="0 0 24 24"><use xlink:href="' . htmlentities($sprites . '#icon-' . $item['icon']) . '"></use></svg>' . htmlentities($item['caption']) . '</a></li>';
					}
					
					?>
				</ul>
			</div>
			<div id="main-content">
				<?php echo $buffer; ?>
			</div>
		</div>
		<div id="blur">&nbsp;</div>
		<div id="user-menu">
			<div id="user-card">
				<div class="usericon">
					<svg viewBox="0 0 24 24"><use xlink:href="<?php echo htmlentities($sprites . '#icon-users'); ?>"></use></svg>
				</div>
				<div class="username">
					<?php echo htmlentities($user->Username()); ?><span class="user-suffix"><?php echo htmlentities('#' . $user->Suffix()); ?></span>
				</div>
			</div>
			<ul>
				<li><a href="#" id="user-menu-copy-id" userid="<?php echo htmlentities($user->UserID()); ?>">Copy User ID</a></li>
				<li><hr></li>
				<li><a href="/account/" id="user-menu-account">My Account</a></li>
				<li><a href="/account/auth?return=%2F" id="user-menu-logout">Log Out</a></li>
			</ul>
		</div>
	</body>
</html>

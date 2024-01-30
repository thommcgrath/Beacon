<?php
$palworld = $gameInfo['Palworld'];
OutputGameHeader('Beacon\'s support for <span class="game-name">Palworld</span> requires a \'<span class="license-name">Beacon Omni for Palworld</span>\' license.', 'Palworld');

if ($palworld['earlyAccess']) {
	echo '<div class="notice-block notice-caution">Palworld is currently Early Access. This game is very new and its future is uncertain. It could grow to support hundreds of config options, die from legal issues, or somewhere in between. Features and pricing subject to change. <strong class="text-red"><a href="/policies/refund" class="text-red">Beacon\'s refund policy</a> remains in effect for Palworld</strong>.</div>';
}

$palworldBuild = ($palworld['majorVersion'] * 10000000) + ($palworld['minorVersion'] * 100000);
$palworldStableBuild = $palworldBuild + 300;
if ($stableVersion < $palworldStableBuild) {
	$buildRows = $database->Query('SELECT stage FROM public.updates WHERE build_number >= $1 ORDER BY build_number DESC LIMIT 1;', $palworldBuild);
	if ($buildRows->RecordCount() === 1) {
		switch ($buildRows->Field('stage')) {
		case 1:
			$previewLabel = 'Alpha Preview';
			break;
		case 2:
			$previewLabel = 'Beta Preview';
			break;
		}
		echo '<div class="notice-block notice-info">Beacon\'s Palworld support requires Beacon version ' . $palworld['majorVersion'] . '.' . $palworld['minorVersion'] . ', which can be downloaded from <a href="/download#preview">the ' . $previewLabel . ' section of the downloads page</a>.</div>';
	} else {
		echo '<div class="notice-block notice-info">Beacon\'s Palworld support requires Beacon version ' . $palworld['majorVersion'] . '.' . $palworld['minorVersion'] . ', which is not ready yet. Sit tight, a new version is coming soon.</div>';
	}
}

?>
<p>Palworld has a small number of options that are not yet complex, so Beacon has just one Palworld editor: General Settings. This is an Omni-exclusive editor in Palworld.</p>
<table class="generic omni-feature-table">
	<thead>
		<tr>
			<th>Feature</th>
			<th class="text-center bullet-column">Beacon Free</th>
			<th class="text-center bullet-column">Beacon Omni</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Nitrado Server Control<br><span class="smaller text-lighter">Nitrado server owners can allow Beacon to directly control their server, including proper restart timing, config editing, and server settings changes.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>GameServerApp.com Support<br><span class="smaller text-lighter">Import and update GameServerApp.com config templates with only a few clicks.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>FTP Upload and Download<br><span class="smaller text-lighter">Beacon can use FTP edit your PalWorldSettings.ini file right on the server.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>Download Community Beacon Files<br><span class="smaller text-lighter">Download Beacon files created by other users to make getting started easier.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>Create Community Beacon Files<br><span class="smaller text-lighter">Share your creation with the world to serve as a starting point for others.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>Custom Config<br><span class="smaller text-lighter">Add settings to your ini file that Beacon doesn't support.</span></td>
			<td class="text-center bullet-column">&check;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
		<tr>
			<td>General Settings<br><span class="smaller text-lighter">Beacon has support for nearly every setting available to Palworld servers.</span></td>
			<td class="text-center bullet-column">&nbsp;</td>
			<td class="text-center bullet-column">&check;</td>
		</tr>
	</tbody>
</table>

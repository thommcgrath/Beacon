<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Mods');
BeaconTemplate::SetCanonicalPath('/Games/Ark/Mods');

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT content_pack_id, marketplace, marketplace_id, name, type FROM public.content_packs_combined WHERE game_id = $1 ORDER BY name;', 'Ark');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Ark', 'Ark: Survival Evolved');
$breadcrumbs->AddComponent('Mods', 'Mods');
echo $breadcrumbs->Render();

?><h1>Supported Mods</h1>
<p>Beacon supports mods, both officially and unofficially! This page lists the Ark mods that Beacon already supports. If you want to add mod items to your own copy of Beacon, <a href="/help/adding_blueprints_to_beacon">here's how</a>. If you are a mod developer and want to add your mod to Beacon for all users to enjoy, <a href="/help/registering_your_mod_with_beacon">it's pretty simple</a>.</p>
<table class="generic">
	<thead>
		<th>Mod Name</th>
		<th>Steam Id</th>
	</thead>
	<tbody>
		<?php
			while (!$rows->EOF()) {
				$marketplace = $rows->Field('marketplace');
				$marketplaceId = $rows->Field('marketplace_id');
				$contentPackId = $rows->Field('content_pack_id');
				$name = $rows->Field('name');
				$type = $rows->Field('type');
				$nameHtml = '<a href="/Games/Ark/Mods/' . htmlentities(urlencode($marketplaceId)) . '">' . htmlentities($name) . '</a>';
				
				$marketplaceUrl = '';
				switch ($marketplace) {
				case 'Steam':
					$marketplaceUrl = 'https://store.steampowered.com/app/' . urlencode($marketplaceId);
					break;
				case 'Steam Workshop':
					$marketplaceUrl = 'https://steamcommunity.com/sharedfiles/filedetails/?id=' . urlencode($marketplaceId);
					break;
				}
				
				switch ($type) {
				case 0:
					break;
				case 1:
					$nameHtml .= '<span class="tag blue ml-3">Author Maintained</span>';
					break;
				case 2:
					$nameHtml = htmlentities($name) . '<span class="tag grey ml-3">Community Maintained</span>';
					break;
				}
				
				?><tr>
			<td><?php echo $nameHtml; ?></td>
			<td><a href="<?php echo htmlentities($marketplaceUrl); ?>" target="_blank"><?php echo htmlentities($marketplaceId); ?></a></td>
		</tr><?php
			$rows->MoveNext();
		} ?>
	</tbody>
</table>
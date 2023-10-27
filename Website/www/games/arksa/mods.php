<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Mods');
BeaconTemplate::SetCanonicalPath('/Games/ArkSA/Mods');

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT content_pack_id, marketplace, marketplace_id, name, type FROM public.content_packs_combined WHERE game_id = $1 ORDER BY name;', 'ArkSA');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('ArkSA', 'Ark: Survival Ascended');
$breadcrumbs->AddComponent('Mods', 'Mods');
echo $breadcrumbs->Render();

$showCommunityLegend = false;
?><h1>Supported Mods</h1>
<p>Beacon supports mods, both officially and unofficially! This page lists the Ark mods that Beacon already supports. If you want to add mod items to your own copy of Beacon, <a href="/help/adding_blueprints_to_beacon">here's how</a>. If you are a mod developer and want to add your mod to Beacon for all users to enjoy, <a href="/help/registering_your_mod_with_beacon">it's pretty simple</a>.</p>
<table class="generic">
	<thead>
		<th class="w-100">Mod Name</th>
		<th class="w-0 nowrap not-mini">Data Source</th>
		<th class="w-0 nowrap">Steam Id</th>
	</thead>
	<tbody>
		<?php
			while (!$rows->EOF()) {
				$marketplace = $rows->Field('marketplace');
				$marketplaceId = $rows->Field('marketplace_id');
				$contentPackId = $rows->Field('content_pack_id');
				$name = $rows->Field('name');
				$type = $rows->Field('type');
				$nameHtml = '<a href="/Games/ArkSA/Mods/' . htmlentities(urlencode($marketplaceId)) . '">' . htmlentities($name) . '</a>';

				$marketplaceUrl = '';
				switch ($marketplace) {
				case 'Steam':
					$marketplaceUrl = 'https://store.steampowered.com/app/' . urlencode($marketplaceId);
					break;
				case 'Steam Workshop':
					$marketplaceUrl = 'https://steamcommunity.com/sharedfiles/filedetails/?id=' . urlencode($marketplaceId);
					break;
				}

				$typeHtml = '';
				switch ($type) {
				case 0:
					$typeHtml = '<span class="tag green">Game Files</span>';
					break;
				case 1:
					$typeHtml = '<span class="tag blue">Mod Author</span>';
					break;
				case 2:
					$nameHtml = htmlentities($name);
					$typeHtml = '<span class="tag grey">Community</span>';
					$showCommunityLegend = true;
					break;
				}

				?><tr>
			<td><?php echo $nameHtml; ?><span class="mini-only"><br><?php echo $typeHtml; ?></span></td>
			<td class="text-center w-0 nowrap not-mini"><?php echo $typeHtml; ?></td>
			<td class="text-right nowrap"><a href="<?php echo htmlentities($marketplaceUrl); ?>" target="_blank"><?php echo htmlentities($marketplaceId); ?></a></td>
		</tr><?php
			$rows->MoveNext();
		} ?>
	</tbody>
</table>
<h2>Legend</h2>
<table>
	<tbody>
		<tr>
			<td class="w-0 p-1 nowrap text-center"><span class="tag green">Game Files</span></td>
			<td class="w-100 p-1">Data is extracted from the game files by the <a href="https://github.com/arkutils/Purlovia">Purlovia project</a>.</td>
		</tr>
		<tr>
			<td class="w-0 p-1 nowrap text-center"><span class="tag blue">Mod Author</span></td>
			<td class="w-100 p-1">Data is maintained by the mod author using Beacon's mod tools.</td>
		</tr>
		<?php if ($showCommunityLegend) { ?><tr>
			<td class="w-0 p-1 nowrap text-center"><span class="tag grey">Community</span></td>
			<td class="w-100 p-1">Data comes from Beacon's <a href="/help/adding_blueprints_to_beacon#using-mod-discovery">Mod Discovery</a> tool.</td>
		</tr><?php } ?>
	</tbody>
</table>

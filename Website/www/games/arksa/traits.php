<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark: Survival Ascended Supported Traits');
BeaconTemplate::SetCanonicalPath('/Games/ArkSA/Traits');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('ArkSA', 'Ark: Survival Ascended');
$breadcrumbs->AddComponent('Traits', 'Traits');
echo $breadcrumbs->Render();

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT label, max_allowed, description, name FROM arksa.traits ORDER BY label;');

?><h1>Supported Traits</h1>
<table class="generic">
	<thead>
		<th class="w-100">Label</th>
		<th class="w-0 nowrap not-mini">Max Allowed</th>
		<th class="w-0 nowrap not-mini">Official Name</th>
	</thead>
	<tbody>
		<?php while (!$rows->EOF()) {
			echo '<tr><td>' . htmlentities($rows->Field('label')) . '<br /><span class="text-lighter smaller">' . htmlentities($rows->Field('description')) . '</span><div class="row-details"><span class="detail">Max Allowed: ' . htmlentities($rows->Field('max_allowed')) . '</span><span class="detail">Official Name: ' . htmlentities($rows->Field('name')) . '</span></div></td><td class="nowrap not-mini">' . htmlentities($rows->Field('max_allowed')) . '</td><td class="nowrap not-mini">' . htmlentities($rows->Field('name')) . '</td></tr>';
			$rows->MoveNext();
		} ?>
	</tbody>
</table>

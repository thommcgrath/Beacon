<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark: Survival Ascended Supported Colors');
BeaconTemplate::SetCanonicalPath('/Games/ArkSA/Colors');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('ArkSA', 'Ark: Survival Ascended');
$breadcrumbs->AddComponent('Colors', 'Colors');
echo $breadcrumbs->Render();

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT * FROM arksa.colors ORDER BY color_id;');

BeaconTemplate::StartStyle();
?><style>

.color-detail {
	display: flex;
	gap: 0.5em;
	align-items: center;
}

.color-detail > .color-detail-hex {
	flex: 1 1 auto;
}

.color-detail > .color-detail-cell {
	flex: 0 0 2em;
	width: 2em;
	height: 1em;
	border-radius: 0.5em;
}

<?php while (!$rows->EOF()) {
	$hex = $rows->Field('color_code');
	echo ".color-detail > .color-detail-cell.color-{$hex} {\n\tbackground-color: #{$hex};\n}\n";
	$rows->MoveNext();
} ?>
</style><?php
BeaconTemplate::FinishStyle();

$rows->MoveFirst();

?><h1>Supported Colors</h1>
<table class="generic">
	<thead>
		<th class="w-0 nowrap">Index</th>
		<th class="w-0 nowrap not-mini">Official Name</th>
		<th class="w-100">Beacon Label</th>
		<th class="w-0 nowrap">Hex Code</th>
	</thead>
	<tbody>
		<?php while (!$rows->EOF()) {
			echo '<tr><td class="nowrap">' . htmlentities($rows->Field('color_id')) . '</td><td class="nowrap not-mini">' . htmlentities($rows->Field('color_name')) . '</td><td>' . htmlentities($rows->Field('color_label')) . '<div class="row-details"><span class="detail">Official Name: ' . htmlentities($rows->Field('color_name')) . '</span></div></td><td class="nowrap"><div class="color-detail"><div class="color-detail-hex">' . htmlentities('#' . strtolower($rows->Field('color_code'))) . '</div><div class="color-detail-cell color-' . htmlentities($rows->Field('color_code')) . '">&nbsp;</div></div></td></tr>';
			$rows->MoveNext();
		} ?>
	</tbody>
</table>

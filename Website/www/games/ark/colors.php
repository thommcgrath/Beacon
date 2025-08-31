<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Ark: Survival Evolved Supported Colors');
BeaconTemplate::SetCanonicalPath('/Games/Ark/Colors');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Ark', 'Ark: Survival Evolved');
$breadcrumbs->AddComponent('Colors', 'Colors');
echo $breadcrumbs->Render();

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT * FROM ark.colors ORDER BY color_id;');

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
		<th class="w-100">Beacon Label</th>
		<th class="w-0 nowrap">Hex Code</th>
	</thead>
	<tbody>
		<?php while (!$rows->EOF()) {
			echo '<tr><td class="nowrap">' . htmlentities($rows->Field('color_id')) . '</td><td>' . htmlentities($rows->Field('color_name')) . '</td><td class="nowrap"><div class="color-detail"><div class="color-detail-hex">' . htmlentities('#' . strtolower($rows->Field('color_code'))) . '</div><div class="color-detail-cell color-' . htmlentities($rows->Field('color_code')) . '">&nbsp;</div></div></td></tr>';
			$rows->MoveNext();
		} ?>
	</tbody>
</table>

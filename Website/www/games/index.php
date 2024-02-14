<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Games');
BeaconTemplate::SetCanonicalPath('/Games');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
echo $breadcrumbs->Render();

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT game_id, game_name FROM public.games WHERE public = TRUE ORDER BY game_name;');

?><h1>Supported Games</h1>
<ul>
	<?php
	while (!$rows->EOF()) {
		echo '<li><a href="/Games/' . htmlentities($rows->Field('game_id')) . '">' . htmlentities($rows->Field('game_name')) . '</a></li>';
		$rows->MoveNext();
	}
	?>
</ul>

<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Games');
BeaconTemplate::SetCanonicalPath('/Games');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
echo $breadcrumbs->Render();

?><h1>Supported Games</h1>
<ul>
	<li><a href="/Games/ArkSA">Ark: Survival Ascended</a></li>
	<li><a href="/Games/Ark">Ark: Survival Evolved</a></li>
</ul>

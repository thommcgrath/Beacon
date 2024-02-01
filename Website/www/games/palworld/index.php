<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Beacon for Palworld', false);
BeaconTemplate::SetCanonicalPath('/Games/Palworld');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Palworld', 'Palworld');
echo $breadcrumbs->Render();

?><h1>Beacon for Palworld</h1>
<p>Palworld has no browsable content.</p>

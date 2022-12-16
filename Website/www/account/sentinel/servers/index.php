<?php

require(dirname(__FILE__, 2) . '/loader.php');
BeaconTemplate::SetVar('Sentinel Sidebar Highlight', 'Servers');
BeaconTemplate::AddScript('/account/sentinel/assets/servers.js');

?><h1>Servers</h1>
<button id="button-add-servers">Add Servers</button>
<pre><?php echo json_encode('', JSON_PRETTY_PRINT); ?></pre>
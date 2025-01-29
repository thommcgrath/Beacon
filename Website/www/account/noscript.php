<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Cache-Control: no-cache');
BeaconTemplate::SetTitle('Beacon Login');
BeaconTemplate::SetBodyClass('purple');


BeaconLogin::OutputNoscriptMessage();

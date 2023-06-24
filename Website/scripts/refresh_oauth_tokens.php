#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

BeaconAPI\v4\OAuth::RefreshExpiring();

echo "Tokens have been refreshed.\n";
exit;

?>

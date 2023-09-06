#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

BeaconAPI\v4\ServiceToken::RefreshExpiring();
echo "Tokens have been refreshed.\n";

?>

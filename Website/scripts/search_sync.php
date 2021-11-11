#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$search = new BeaconSearch();
if ($search->Sync()) {
	echo "Sync finished\n";
} else {
	echo "Sync failed\n";
	echo $search->RawResponse() . "\n";
}

?>

<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

header('Content-Type: text/plain');

echo "User-agent: MJ12bot\nDisallow: /\n\n";

if (BeaconCommon::InProduction()) {
	echo "User-agent: *\nAllow: /";
} else {
	echo "User-agent: *\nDisallow: /";
}

?>
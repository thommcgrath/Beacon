<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

header('Content-Type: text/plain');

if (BeaconCommon::InProduction()) {
	echo "User-agent: *\nAllow: /";
} else {
	echo "User-agent: *\nDisallow: /";
}

?>
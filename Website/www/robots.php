<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

header('Content-Type: text/plain');

echo "User-agent: *\nDisallow: /download/\nDisallow: /search/\n";

if (BeaconCommon::InProduction()) {
	echo 'Allow: /';
} else {
	echo 'Disallow: /';
}

?>
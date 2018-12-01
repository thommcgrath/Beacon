<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/opensearchdescription+xml');

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";

?><OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/">
	<ShortName>Beacon</ShortName>
	<Description>Search for details about Ark and Beacon for Ark</Description>
	<Tags>ark survival evolved</Tags>
	<Contact>forgotmyparachute@beaconapp.cc</Contact>
	<Url type="application/rss+xml" template="<?php echo BeaconCommon::AbsoluteURL('/search/?query={searchTerms}'); ?>"/>
	<Url type="text/html" template="<?php echo BeaconCommon::AbsoluteURL('/search/?query={searchTerms}'); ?>"/>
	<Image width="16" height="16" type="image/x-icon"><?php echo BeaconCommon::AbsoluteURL('/assets/favicon/favicon.ico'); ?></Image>
	<InputEncoding>UTF-8</InputEncoding>
	<Query role="example" searchTerms="Loot" />
 </OpenSearchDescription>
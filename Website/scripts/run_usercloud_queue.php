#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

BeaconCloudStorage::RunQueue();

?>
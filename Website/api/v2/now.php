<?php

require(dirname(__FILE__) . '/loader.php');

$now = new DateTime('now', new DateTimeZone('UTC'));
echo $now->format('Y-m-d H:i:sO');

?>
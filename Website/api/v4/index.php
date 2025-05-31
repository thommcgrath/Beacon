<?php

namespace BeaconAPI\v4;

define('API_ROOT', dirname(__FILE__));
require(API_ROOT . '/loader.php');
require(API_ROOT . '/router.php');
Core::HandleRequest(API_ROOT . '/requests');

?>

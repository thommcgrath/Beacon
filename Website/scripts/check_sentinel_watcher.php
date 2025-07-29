#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$watcherRoot = dirname(__FILE__, 2) . '/watcher';
$installPath = $watcherRoot . '/bin';
$heartbeatFile = $installPath . '/heartbeat';

if (file_exists($heartbeatFile) === false) {
	echo "Watcher does not appear to be running.\n";
	exit;
}

$lastHeartbeat = file_get_contents($heartbeatFile);
$now = time();
$delta = $now - (int)$lastHeartbeat;
if ($delta > 30) {
	exec('killall -s 9 sentinelwatcher');
	unlink($heartbeatFile);
	exec(escapeshellarg("{$installPath}/startwatcher.sh"));
	echo "Watcher has been restarted.\n";
} else {
	echo "Watcher is running fine.\n";
}

?>

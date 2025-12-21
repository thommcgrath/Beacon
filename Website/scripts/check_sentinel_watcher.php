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

$fileContents = file_get_contents($heartbeatFile);
if (is_numeric($fileContents)) {
	$heartbeats = ['Main' => (float)$fileContents];
} else {
	$heartbeats = json_decode($fileContents, true);
}

$now = time();
foreach ($heartbeats as $thread => $lastHeartbeat) {
	$delta = $now - (int)$lastHeartbeat;
	if ($delta <= 30) {
		continue;
	}

	exec('killall -s 9 sentinelwatcher');
	unlink($heartbeatFile);
	exec(escapeshellarg("{$installPath}/startwatcher.sh"));
	echo "Thread {$thread} was stuck. Watcher has been restarted.\n";
	exit;
}

echo "Watcher is running fine.\n";

?>

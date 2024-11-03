#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$root = dirname(__FILE__, 3);
$return_code = 0;
ob_start();
system('cd ' . escapeshellarg($root) . ' && git rev-parse --abbrev-ref HEAD', $return_code);
$current_branch = trim(ob_get_contents());
ob_end_clean();
if ($return_code !== 0) {
	echo "Failed to get current branch:\n";
	echo "$current_branch\n";
	exit;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT hash FROM public.endpoint_git_hashes WHERE branch = $1;', $current_branch);
if ($results->RecordCount() === 0) {
	echo "No records for branch $current_branch.\n";
	exit;
}


$desired_hash = $results->Field('hash');
$return_code = 0;
ob_start();
system('cd ' . escapeshellarg($root) . ' && git rev-parse HEAD', $return_code);
$current_hash = trim(ob_get_contents());
ob_end_clean();
if ($return_code !== 0) {
	echo "Failed to get current hash:\n";
	echo "$current_hash\n";
	exit;
}

if ($current_hash === $desired_hash) {
	echo "Already up to date.\n";
	exit;
}

$commands = [
	'cd ' . escapeshellarg($root),
	'git clean -fd',
	'git pull',
	'git reset --hard ' . escapeshellarg($desired_hash),
];

if (file_exists("{$root}/Website/composer.phar")) {
	$commands[] = 'php ' . escapeshellarg("Website/composer.phar") . ' self-update --quiet';
	$commands[] = 'php ' . escapeshellarg("Website/composer.phar") . ' install --no-interaction --prefer-install=source --no-progress --quiet --working-dir=Website';
} elseif (file_exists("{$root}/Website/composer.json")) {
	$commands[] = "php -r \"copy('https://getcomposer.org/installer', 'Website/composer-setup.php');\"";
	$commands[] = 'php ' . escapeshellarg("Website/composer-setup.php") . ' --install-dir=' . escapeshellarg("Website");
	$commands[] = 'rm ' . escapeshellarg("Website/composer-setup.php");
	$commands[] = 'php ' . escapeshellarg("Website/composer.phar") . ' install --no-interaction --prefer-install=source --no-progress --quiet --working-dir=Website';
}

if (is_dir('/etc/nginx')) {
	$commands[] = 'sudo systemctl reload nginx';
}

$command = implode(' && ', $commands) . ' 2>&1';
$return_code = 0;
ob_start();
system($command, $return_code);
$output = ob_get_contents();
ob_end_clean();

if ($return_code !== 0) {
	BeaconCommon::PostSlackMessage('Endpoint ' . gethostname() . ' failed to pull git changes.');
	echo "$command returned $return_code\n";
	echo "$output\n";
	exit;
}

opcache_reset();

?>

#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$_SERVER['DBOMFrontMatter'] = [];

define('API_ROOT', dirname(__FILE__));
require(dirname(__FILE__, 2) . '/api/v4/router.php');

$titleSwaps = [
	'SDTD' => '7 Days to Die',
	'Ark' => 'Ark: Survival Evolved',
	'ArkSA' => 'Ark: Survival Ascended',
];

foreach ($_SERVER['DBOMFrontMatter'] as $location => $frontMatter) {
	if (file_exists($location)) {
		continue;
	}

	mkdir($location, 0755, true);

	if (array_key_exists($frontMatter['parent'], $titleSwaps)) {
		$frontMatter['parent'] = $titleSwaps[$frontMatter['parent']];
	}

	$lines = ['---'];
	foreach ($frontMatter as $key => $value) {
		if (is_array($value)) {
			$lines[] = "{$key}:";
			foreach ($value as $requestMethod) {
				$lines[] = "  - {$requestMethod}";
			}
			continue;
		} elseif (is_bool($value)) {
			if ($value) {
				$lines[] = "{$key}: true";
			} else {
				$lines[] = "{$key}: false";
			}
			continue;
		} elseif (is_string($value)) {
			$lines[] = "{$key}: \"{$value}\"";
			continue;
		}

		$lines[] = "{$key}: {$value}";
	}
	$lines[] = '---';
	$lines[] = '# {{page.title}}';
	$lines[] = '';
	$lines[] = '{% capture sample_object %}';
	$lines[] = '{}';
	$lines[] = '{% endcapture %}';
	$lines[] = "{% include classdefinition.markdown sample=sample_object %}";

	file_put_contents($location . '/index.markdown', implode("\n", $lines));
}

?>

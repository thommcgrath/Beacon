<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$terms = '';
if (isset($_GET['query'])) {
	$terms = $_GET['query'];
}
$request_content_type = 'text/html';
if (isset($_SERVER['HTTP_ACCEPT'])) {
	$request_content_type = strtolower($_SERVER['HTTP_ACCEPT']);
}

if ($request_content_type === 'application/rss+xml') {
	http_response_code(404);
	header('Content-Type: text/plain');
	echo 'File not found';
	exit;
}

$version = BeaconCommon::NewestVersionForStage(3);
$max_results = 100;
if (isset($_GET['count'])) {
	$max_results = min(intval($_GET['count']), $max_results);
}

$search = new BeaconSearch('12877547-7ad0-466f-a001-77815043c96b');
$results = $search->Search($terms, $version, $max_results);
$items = [];
foreach ($results as $result) {
	$summary = $result['preview'];
	if (empty($summary)) {
		$summary = $result['body'];
	}
	if (strlen($summary) > 200) {
		$pos = strpos($summary, ' ', 200);
		if ($pos !== false) {
			$summary = trim(substr($summary, 0, $pos)) . '…';
		}
	}

	$type = $result['type'];
	if ($type == 'Object') {
		switch ($result['subtype']) {
		case 'engrams':
			$type = 'Engram';
			break;
		case 'loot_sources':
		case 'loot_drops':
			$type = 'Loot Drop';
			break;
		case 'spawn_points':
			$type = 'Spawn Point';
			break;
		case 'creatures':
			$type = 'Creature';
			break;
		}
	} elseif ($type == 'Document') {
		$type = 'Project';
	}

	$item = [
		'id' => $result['objectID'],
		'title' => $result['title'],
		'summary' => $summary,
		'type' => $type,
		'quality' => 1,
		'url' => $result['uri'],
		'mod' => [
			'id' => $result['mod_id'],
			'name' => $result['mod_name']
		]
	];
	if (isset($result['game_id'])) {
		$item['game'] = [
			'id' => $result['game_id'],
			'name' => $result['game_name'] ?? '',
		];
	}

	$items[] = $item;
}
$result_count = $search->TotalResultCount();

if ($request_content_type === 'application/json') {
	header('Content-Type: application/json');
	echo json_encode($response = array(
		'terms' => $terms,
		'results' => $items,
		'total' => $result_count
	));
	exit;
}

if (empty($terms)) {
	header('Location: /');
	exit;
}

echo '<h1>Search Results</h1>';

if (count($items) == 0) {
	echo '<p>Sorry, no results for &quot;' . htmlentities($terms) . '&quot;</p>';
	exit;
}

echo '<div class="results">';
foreach ($items as $item) {
	echo '<div class="result"><a href="' . $item['url'] . '">' . htmlentities($item['title']) . '</a><span class="result_type">' . (isset($item['game']) ? htmlentities($item['game']['name']) . ' ' : '') . htmlentities($item['type']) . (isset($item['mod']['name']) ? htmlentities(' from ' . $item['mod']['name']) : '') . '</span>';
	if ($item['summary'] !== '') {
		echo '<br><span class="summary">' . nl2br(htmlentities($item['summary'])) . '</span>';
	}
	echo '</div>';
}
echo '</div>';

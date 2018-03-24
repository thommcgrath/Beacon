<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$terms = '';
if (isset($_GET['query'])) {
	$terms = $_GET['query'];
}

$max_results = 100;
if (isset($_GET['count'])) {
	$max_results = min(intval($_GET['count']), $max_results);
}

// massage the terms
$query = preg_replace('/[^a-z ]/', '', strtolower($terms));
$query = preg_replace('/\s+/', ' | ', trim($query));
$query = preg_replace('/(\w+)/', '$1:*', $query);

$database = BeaconCommon::Database();
$results = $database->Query('SELECT id, title, type, ts_rank(lexemes, keywords) AS rank FROM search_contents, to_tsquery($1) AS keywords WHERE keywords @@ lexemes ORDER BY rank DESC, title ASC LIMIT $2;', $query, $max_results);
$items = array();
while (!$results->EOF()) {
	$item = array(
		'id' => $results->Field('id'),
		'title' => $results->Field('title'),
		'type' => $results->Field('type'),
		'quality' => floatval($results->Field('rank')),
	);
	
	switch ($item['type']) {
	case 'Document':
		$item['url'] = '/browse/view.php?document_id=' . urlencode($item['id']);
		break;
	case 'Article':
		$item['url'] = '/read.php/' . urlencode($item['id']);
		break;
	case 'Object':
		$item['url'] = '/object.php/' . urlencode($item['id']);
		break;
	case 'Mod':
		$item['url'] = '/mods/info.php?mod_id=' . urlencode($item['id']);
		break;
	default:
		$item['url'] = '/';
		break;
	}
	
	$items[] = $item;
	$results->MoveNext();
}

if (isset($_SERVER['HTTP_ACCEPT']) && $_SERVER['HTTP_ACCEPT'] === 'application/json') {
	header('Content-Type: application/json');
	echo json_encode($response = array(
		'terms' => $terms,
		'results' => $items
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

echo '<ul class="results">';
foreach ($items as $item) {
	echo '<li><span class="result_type">' . htmlentities($item['type']) . '</span> <a href="' . $item['url'] . '">' . htmlentities($item['title']) . '</a></li>';
}
echo '</ul>';
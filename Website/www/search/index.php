<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

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

$items = array();
$results = $database->Query('SELECT COUNT(id) AS result_count FROM search_contents, to_tsquery($1) AS keywords WHERE keywords @@ lexemes AND min_version <= $2;', $query, BeaconCommon::MinVersion());
$result_count = $results->Field('result_count');
$name_map = [];
if ($result_count > 0) {
	$results = $database->Query('SELECT id, title, body, type, subtype, uri, mods.mod_id, mods.name AS mod_name, ts_rank(lexemes, keywords) AS rank FROM search_contents LEFT JOIN mods ON (search_contents.mod_id = mods.mod_id), to_tsquery($1) AS keywords WHERE keywords @@ lexemes AND min_version <= $3 ORDER BY rank DESC, title ASC LIMIT $2;', $query, $max_results, BeaconCommon::MinVersion());
	while (!$results->EOF()) {
		$summary = $results->Field('body');
		if (strlen($summary) > 200) {
			$pos = strpos($summary, ' ', 200);
			if ($pos !== false) {
				$summary = trim(substr($summary, 0, $pos)) . '…';
			}
		}
		
		$type = $results->Field('type');
		if ($type == 'Object') {
			switch ($results->Field('subtype')) {
			case 'engrams':
				$type = 'Engram';
				break;
			case 'loot_sources':
				$type = 'Loot Source';
				break;
			case 'spawn_points':
				$type = 'Spawn Point';
				break;
			case 'creatures':
				$type = 'Creature';
				break;
			}
		}
		
		$item = [
			'id' => $results->Field('id'),
			'title' => $results->Field('title'),
			'summary' => $summary,
			'type' => $type,
			'quality' => floatval($results->Field('rank')),
			'url' => $results->Field('uri'),
			'mod' => [
				'id' => $results->Field('mod_id'),
				'name' => $results->Field('mod_name')
			]
		];
		if (isset($name_map[$results->Field('title')])) {
			$name_map[$results->Field('title')] = $name_map[$results->Field('title')] + 1;
		} else {
			$name_map[$results->Field('title')] = 1;
		}
		
		$items[] = $item;
		$results->MoveNext();
	}
}

for ($idx = 0; $idx < count($items); $idx++) {
	$title = $items[$idx]['title'];
	if ($name_map[$title] > 1 && is_null($items[$idx]['mod']['name']) == false) {
		$items[$idx]['title'] = $title . ' (' . $items[$idx]['mod']['name'] . ')';
	}
}

if (isset($_SERVER['HTTP_ACCEPT'])) {
	switch ($_SERVER['HTTP_ACCEPT']) {
	case 'application/json':
		header('Content-Type: application/json');
		echo json_encode($response = array(
			'terms' => $terms,
			'results' => $items,
			'total' => $result_count
		));
		exit;
	case 'application/rss+xml':
		header('Content-Type: application/rss+xml');
		echo '<?xml version="1.0" encoding="UTF-8"?>';
		echo '<rss version="2.0" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/" xmlns:atom="http://www.w3.org/2005/Atom">';
		echo '<channel>';
		echo '<title>Beacon</title>';
		echo '<link>' . BeaconCommon::AbsoluteURL('/') . '</link>';
		echo '<description>Search results for Beacon, a loot editor for Ark: Survival Evolved.</description>';
		echo '<opensearch:totalResults>' . $result_count . '</opensearch:totalResults>';
		echo '<opensearch:startIndex>0</opensearch:startIndex>';
		echo '<opensearch:itemsPerPage>' . $max_results . '</opensearch:itemsPerPage>';
		echo '<atom:link rel="search" type="application/opensearchdescription+xml" href="' . htmlentities(BeaconCommon::AbsoluteURL('/search/opensearch.php')) . '"/>';
		echo '<opensearch:Query role="request" searchTerms="' . htmlentities($terms) . '" startPage="1" />';
		
		foreach ($items as $item) {
			echo '<item>';
			echo '<title>' . htmlentities($item['title']) . '</title>';
			echo '<link>' . htmlentities(BeaconCommon::AbsoluteURL($item['url'])) . '</link>';
			echo '<description>' . htmlentities($item['summary']) . '</description>';
			echo '</item>';
		}
		
		echo '</channel>';
		echo '</rss>';
		
		exit;
	}
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
	echo '<div class="result"><a href="' . $item['url'] . '">' . htmlentities($item['title']) . '</a><span class="result_type">' . htmlentities($item['type']) . '</span>';
	if ($item['summary'] !== '') {
		echo '<br><span class="summary">' . nl2br(htmlentities($item['summary'])) . '</span>';
	}
	echo '</div>';
}
echo '</div>';
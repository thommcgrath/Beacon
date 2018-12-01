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
$results = $database->Query('SELECT COUNT(id) AS result_count FROM search_contents, to_tsquery($1) AS keywords WHERE keywords @@ lexemes;', $query);
$result_count = $results->Field('result_count');
if ($result_count > 0) {
	$results = $database->Query('SELECT id, title, body, type, ts_rank(lexemes, keywords) AS rank FROM search_contents, to_tsquery($1) AS keywords WHERE keywords @@ lexemes ORDER BY rank DESC, title ASC LIMIT $2;', $query, $max_results);
	while (!$results->EOF()) {
		$summary = $results->Field('body');
		if (strlen($summary) > 200) {
			$pos = strpos($summary, ' ', 200);
			$summary = trim(substr($summary, 0, $pos)) . '…';
		}
		
		$item = array(
			'id' => $results->Field('id'),
			'title' => $results->Field('title'),
			'summary' => $summary,
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
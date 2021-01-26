<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (!isset($_GET['query'])) {
	BeaconCommon::Redirect('/help/');
	exit;
}

$terms = $_GET['query'];
$query = preg_replace('/[^a-z ]/', '', strtolower($terms));
$query = preg_replace('/\s+/', ' | ', trim($query));
$query = preg_replace('/(\w+)/', '$1:*', $query);
$database = BeaconCommon::Database();

BeaconTemplate::SetTitle('Help: ' . $terms);

$stable_version = BeaconCommon::NewestVersionForStage(3);
$version = $stable_version;
if (isset($_GET['version'])) {
	$input_version = $_GET['version'];
	$parsed_version = BeaconCommon::VersionToBuildNumber($input_version);
	if ($parsed_version > 0) {
		$version = $parsed_version;
	}
}
$stage = intval(substr($version, -3, 1));
$latest_version = BeaconCommon::NewestVersionForStage($stage);
if ($version !== $latest_version) {
	// redirect
	if ($stage === 3) {
		header('Location: /help/' . $current_slug);
	} else {
		header('Location: /help/' . BeaconCommon::BuildNumberToVersion($latest_version) . '/' . $current_slug);
	}
	http_response_code(301);
	exit;
}
$include_url_version = ($stage !== 3);
$version_formatted = BeaconCommon::BuildNumberToVersion($version);

$results = $database->Query('SELECT support_articles.subject, support_articles.preview, search_contents.uri, ts_rank(lexemes, keywords) AS rank FROM search_contents INNER JOIN support_articles ON (search_contents.id = support_articles.article_id), to_tsquery($1) AS keywords WHERE type = \'Help\' AND keywords @@ lexemes AND search_contents.min_version <= $2 AND search_contents.max_version >= $2 ORDER BY rank DESC, title ASC;', $query, $version);
if ($results->RecordCount() == 0) {
	$html = '<h1>No Results</h1><p>Could not find anything for &quot;' . htmlentities($terms) . '&quot;</p>';
} else {
	BeaconTemplate::StartStyles(); ?>
	<style>
	
	div.support_result {
		padding: 15px;
		
		&:first-child {
			margin-top: 15px;
		}
		
		&:last-child {
			margin-bottom: 15px;
		}
		
		&+div.support_result {
			border-top-width: 1px;
			border-top-style: solid;
			margin-top: 0px;
		}
	}
	
	</style>
	<?php
	BeaconTemplate::FinishStyles();
	
	$html = '<h1>Search Results for &quot;' . htmlentities($terms) . '&quot;</h1>';
	while (!$results->EOF()) {
		$path = $results->Field('uri');
		if ($include_url_version) {
			$path = str_replace('/help/', '/help/' . urlencode($version_formatted) . '/', $path);
		}
		$html .= '<div class="support_result separator-color"><h3><a href="' . $path . '">' . htmlentities($results->Field('subject')) . '</a></h3><p>' . htmlentities($results->Field('preview')) . '</p></div>';
		
		$results->MoveNext();
	}
}

include('inc.knowledge.php');
ShowKnowledgeContent($html, '');

?>
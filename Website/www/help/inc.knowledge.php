<?php

function ShowKnowledgeContent(string $html, string $current_slug) {
	$database = BeaconCommon::Database();
	$stable_version = BeaconCommon::NewestVersionForStage(3);
	$version = $stable_version;
	if (isset($_GET['version'])) {
		$input_version = $_GET['version'];
		$parsed_version = BeaconCommon::VersionToBuildNumber($input_version);
		if ($parsed_version > 0) {
			$version = $parsed_version;
		}
	}
	if ($version === 0) {
		$version = $stable_version;
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
	
	echo '<div id="knowledge_wrapper">';
	
	$results = $database->Query('SELECT support_articles.article_slug, support_articles.subject, support_articles.forward_url, support_article_groups.group_name, support_article_groups.sort_order AS group_sort_order, support_articles.sort_order AS article_sort_order FROM support_articles INNER JOIN support_article_groups ON (support_articles.group_id = support_article_groups.group_id) WHERE support_articles.published = TRUE AND min_version <= $1 AND max_version >= $1 ORDER BY support_article_groups.sort_order, support_article_groups.sort_order, support_articles.sort_order, support_articles.subject;', $version);
	$toc = array();
	while (!$results->EOF()) {
		$group_name = $results->Field('group_name');
		$group_contents = array();
		if (array_key_exists($group_name, $toc)) {
			$group_contents = $toc[$group_name];
		}
		$group_contents[] = array(
			'slug' => $results->Field('article_slug'),
			'subject' => $results->Field('subject'),
			'forward' => $results->Field('forward_url')
		);
		$toc[$group_name] = $group_contents;
		$results->MoveNext();
	}
	
	echo '<div id="knowledge_contents">';
	
	BeaconTemplate::StartScript(); ?>
	<script>
		
	document.addEventListener('DOMContentLoaded', function() {
		document.getElementById('knowledge_search_form').addEventListener('submit', function(ev) {
			var query = document.getElementById('knowledge_search_field').value;
			var url = '/help/search/' + encodeURIComponent(query);
			
			window.location = url;
			this.disabled = true;
			ev.preventDefault();
		});
	});
	
	</script>
	<?php
	BeaconTemplate::FinishScript();
	
	echo '<div id="knowledge_search_block"><form action="/help/search" method="get" id="knowledge_search_form"><input type="search" placeholder="Search For Help" name="query" id="knowledge_search_field" recents="0" value="' . (isset($_GET['query']) ? htmlentities($_GET['query']) : '') . '"></form></div>';
	
	echo '<p id="knowledge_version">Version: ' . htmlentities($version_formatted) . '</p>';
	
	foreach ($toc as $group_name => $group_contents) {
		echo '<p>' . htmlentities($group_name) . '</p><ul>';
		foreach ($group_contents as $article) {
			if ($article['slug'] == $current_slug) {
				echo '<li class="current">' . htmlentities($article['subject']) . '</li>';
			} elseif (!is_null($article['forward'])) {
				echo '<li><a href="' . $article['forward'] . '">' . htmlentities($article['subject']) . '</a></li>';
			} else {
				echo '<li><a href="/help/' . ($include_url_version ? urlencode($version_formatted) . '/' : '') . $article['slug'] . '">' . htmlentities($article['subject']) . '</a></li>';
			}
		}
		echo '</ul>';
	}
	echo '</div>';
	echo '<div id="knowledge_main">' . $html . '</div>';
	echo '</div>';
}

?>
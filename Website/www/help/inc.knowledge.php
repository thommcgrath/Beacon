<?php

function ShowKnowledgeContent(string $html, string $current_slug) {
	$database = BeaconCommon::Database();
	
	echo '<div id="knowledge_wrapper">';
	echo '<div id="knowledge_main">' . $html . '</div>';
	
	$results = $database->Query('SELECT support_articles.article_slug, support_articles.subject, support_articles.forward_url, support_article_groups.group_name, support_article_groups.sort_order, support_table_of_contents.sort_order FROM (support_article_groups INNER JOIN support_table_of_contents ON (support_table_of_contents.group_id = support_article_groups.group_id)) LEFT JOIN support_articles ON (support_table_of_contents.article_id = support_articles.article_id) WHERE support_articles.published = TRUE ORDER BY support_article_groups.sort_order, support_table_of_contents.sort_order, support_article_groups.group_name, support_articles.subject;');
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
	
	foreach ($toc as $group_name => $group_contents) {
		echo '<p>' . htmlentities($group_name) . '</p><ul>';
		foreach ($group_contents as $article) {
			if ($article['slug'] == $current_slug) {
				echo '<li class="current">' . htmlentities($article['subject']) . '</li>';
			} elseif (!is_null($article['forward'])) {
				echo '<li><a href="' . $article['forward'] . '">' . htmlentities($article['subject']) . '</a></li>';
			} else {
				echo '<li><a href="/help/' . $article['slug'] . '">' . htmlentities($article['subject']) . '</a></li>';
			}
		}
		echo '</ul>';
	}
	echo '</div>';
	echo '</div>';
}

?>
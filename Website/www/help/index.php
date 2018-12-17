<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Help');

$default_island_document = BeaconDocumentMetadata::GetByDocumentID('eab656ca-20c6-4bec-bd15-6066f0fb16d3');
$default_scorched_document = BeaconDocumentMetadata::GetByDocumentID('08bccb22-3c06-4982-b267-c2abd81e959a');
$default_island_updated = (count($default_island_document) == 1) ? $default_island_document[0]->LastUpdated() : null;
$default_scorched_updated = (count($default_scorched_document) == 1) ? $default_scorched_document[0]->LastUpdated() : null;

?><h1>Getting Started</h1>
<div class="indent">
	<p>New users who have no idea how to start customizing loot should <a href="gettingstarted.php">read this</a>.</p>
</div>
<h2>All Help Topics</h2>
<div class="indent">
	<p>Your best option for help is to first use the search box to the left. But here's a full list of the available help topics.</p>
	<ul><?php
	
	$articles = BeaconArticleMetadata::GetAll('Help');
	foreach ($articles as $article) {
		echo '<li><a href="/read/' . $article->ArticleID() . '">' . htmlentities($article->Title()) . '</a></li>';
	}
	
	?></ul>
</div>
<h2>Some more personal help</h2>
<div class="indent">
	<p>Get in touch. Bugs should be reported on the <a href="/reportaproblem.php">GitHub page</a>. Anybody can create an account and this is more helpful than email when it comes to bugs. General help inquiries should be sent to <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
	<p class="text-center"><a href="/discord.php"><img class="white-on-dark" height="64" src="/assets/images/discord-full-color.svg"></a></p>
	<p>Beacon has a <a href="/discord.php">Discord server</a>. Come ask questions, but realize that people need to sleep.</p>
</div>
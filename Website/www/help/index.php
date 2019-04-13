<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Help');

ob_start();
?><h2>Getting Started</h2>
<div class="indent">
	<p>New users who have no idea how to start customizing loot should <a href="/videos/introduction_to_loot_drops_with">watch this introductory video</a>.</p>
</div>
<h2>Some more personal help</h2>
<div class="indent">
	<p>Get in touch. Bugs should be reported on the <a href="/reportaproblem.php">GitHub page</a>. Anybody can create an account and this is more helpful than email when it comes to bugs. General help inquiries should be sent to <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
	<p class="text-center"><a href="/discord.php"><img class="white-on-dark" height="64" src="/assets/images/discord-full-color.svg"></a></p>
	<p>Beacon has a <a href="/discord.php">Discord server</a>. Come ask questions, but realize that people need to sleep.</p>
</div><?php
$html = ob_get_contents();
ob_end_clean();

include('inc.knowledge.php');
ShowKnowledgeContent($html, '');

?>
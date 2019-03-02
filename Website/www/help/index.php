<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Help');

BeaconTemplate::StartStyles(); ?>
<style>

#support_search_block {
	text-align: center;
	margin-bottom: 40px;
}

#support_search_field {
	max-width: 60%;
	margin-right: 15px;
}

#support_search_button {
	vertical-align: baseline;
}

</style>
<?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
	
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('support_search_form').addEventListener('submit', function(ev) {
		var query = document.getElementById('support_search_field').value;
		var url = '/help/search/' + encodeURIComponent(query);
		
		window.location = url;
		this.disabled = true;
		ev.preventDefault();
	});
});

</script>
<?php
BeaconTemplate::FinishScript();

?>
<div id="support_search_block">
	<form action="/help/search.php" method="get" id="support_search_form">
		<p><input type="search" placeholder="Search For Help" name="query" id="support_search_field" recents="0"><input type="submit" value="Search" id="support_search_button"></p>
	</form>
</div>
<h2>Getting Started</h2>
<div class="indent">
	<p>New users who have no idea how to start customizing loot should <a href="/videos/introduction_to_loot_drops_with">watch this introductory video</a>.</p>
</div>
<h2>Some more personal help</h2>
<div class="indent">
	<p>Get in touch. Bugs should be reported on the <a href="/reportaproblem.php">GitHub page</a>. Anybody can create an account and this is more helpful than email when it comes to bugs. General help inquiries should be sent to <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
	<p class="text-center"><a href="/discord.php"><img class="white-on-dark" height="64" src="/assets/images/discord-full-color.svg"></a></p>
	<p>Beacon has a <a href="/discord.php">Discord server</a>. Come ask questions, but realize that people need to sleep.</p>
</div>
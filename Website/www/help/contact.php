<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Submit Ticket');
BeaconTemplate::SetPageDescription('Submit a new support request');
BeaconTemplate::AddScript(BeaconCommon::AssetURI('contact.js'));

$current_timestamp = time();
$psk = BeaconCommon::GetGlobal('Support Ticket Key');
$hash = hash('sha256', $current_timestamp . $psk);

ob_start();
?>
<h1 class="mb-4">Submit a new support request</h1>
<div class="m-0">
	<div id="pageInitial" class="larger">
		<p>If you have Beacon installed, please open a ticket from inside the app. This will allow you to include your project, as well as log files and backups, which will get you a better and faster answer.</p>
		<ul class="no-markings">
			<li class="my-3"><a href="beacon://action/newhelpticket">I have Beacon installed, take me to the help form.</a></li>
			<li class="mt-3"><a href="#" id="showWebFormLink">I cannot access Beacon's built-in help form.</a></li>
		</ul>
	</div>
	<div id="pageContactForm" class="hidden">
		<div id="contactErrorNotice" class="notice-block notice-warning hidden mb-3">Hey, it looks like the form wasn't filled out completely. Please give it another look.</div>
		<form method="post" action="/help/contact" id="contactForm">
			<div class="hidden">
				<input type="hidden" name="timestamp" id="contactTimestampField" value="<?php echo htmlentities($current_timestamp); ?>">
				<input type="hidden" name="hash" id="contactHashField" value="<?php echo htmlentities($hash); ?>">
			</div>
			<div class="floating-label mt-0 mb-3"><input class="text-field" type="text" placeholder="Name" name="username" id="contactNameField" required><label for="contactNameField">Name</label></div>
			<div class="floating-label my-3"><input class="text-field" type="email" placeholder="E-Mail Address" name="email" id="contactEmailField" required><label for="contactEmailField">E-Mail Address</label></div>
			<div class="floating-label my-3">
				<div class="select hide-first"><span></span><select name="platform" id="contactPlatformField" required>
					<option disabled selected></option>
					<option value="Steam">Steam</option>
					<option value="Epic">Epic Games Store</option>
					<option value="Xbox">Xbox / Windows Store</option>
					<option value="PlayStation">PlayStation</option>
					<option value="Other">Switch / Mobile / Other</option>
				</select></div>
				<label for="contactPlatformField">Platform</label>
			</div>
			<div class="floating-label mt-3 mb-1"><input class="text-field" type="text" placeholder="Hosting Provider" name="host" id="contactHostField" required><label for="contactHostField">Hosting Provider</label></div>
			<div class="smaller text-lighter mt-1 mb-3">For example: Nitrado, GPortal, single player, self-hosted.</div>
			<div class="my-3"><textarea name="body" id="contactBodyField" placeholder="How can we help?" rows="14"></textarea></div>
			<div class="my-3 text-center"><input type="submit" id="contactActionButton" value="Submit"></div>
		</form>
	</div>
</div>
<?php
$html = ob_get_contents();
ob_end_clean();

include('inc.knowledge.php');
ShowKnowledgeContent($html, '');

?>
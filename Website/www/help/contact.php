<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Submit Ticket');
BeaconTemplate::SetPageDescription('Submit a new support request');
BeaconTemplate::AddScript('/assets/scripts/contact.js');
ob_start();
?><h2>Submit a new support request</h2>
<div id="contactErrorNotice" class="notice-block notice-warning hidden">Hey, it looks like the form wasn't filled out completely. Please give it another look.</div>
<form method="post" action="/help/contact" id="contactForm">
	<table width="100%" cellpadding="0" cellspacing="10">
		<tr>
			<td class="text-right bold">Name:</td>
			<td><input type="text" placeholder="Name" name="username" id="contactNameField" required></td>
		</tr>
		<tr>
			<td class="text-right bold">Email:</td>
			<td><input type="email" placeholder="E-Mail Address" name="email" id="contactEmailField" required></td>
		</tr>
		<tr>
			<td class="text-right bold">Platform:</td>
			<td><div class="select"><span></span><select name="platform" id="contactPlatformField" required>
				<option disabled selected></option>
				<option value="Steam">Steam</option>
				<option value="Epic">Epic Games Store</option>
				<option value="Xbox">Xbox / Windows Store</option>
				<option value="PlayStation">PlayStation</option>
				<option value="Other">Switch / Mobile / Other</option>
			</select></div></td>
		</tr>
		<tr>
			<td class="text-right bold">Host:</td>
			<td><input type="text" placeholder="Hosting Provider" name="host" id="contactHostField" required><br><span class="smaller text-lighter">For example: Nitrado, GPortal, single player, self-hosted</span></td>
		</tr>
		<tr>
			<td colspan="2"><textarea name="body" id="contactBodyField" placeholder="How can we help?" rows="14"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" class="text-right"><input type="submit" id="contactActionButton" value="Submit"></td>
		</tr>
	</table>
</form>
<?php
$html = ob_get_contents();
ob_end_clean();

include('inc.knowledge.php');
ShowKnowledgeContent($html, '');

?>
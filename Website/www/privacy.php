<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Beacon Privacy Policy');
?><h1>Beacon Privacy Policy</h1>
<div class="indent">
	<p><strong>Here it is in simple non-lawyer terms</strong>: I have zero interest in your personal data. My users are not a commodity. My website doesn't even run Google Analytics.</p>
	<p>The Beacon Announce mailing list is run by MailChimp. They handle the subscribers, double-opt-in mechanics, etc. I do not log any data about the subscribers on my own servers.</p>
	<p>When publishing a Beacon document, your Beacon ID and public key is stored on my server. This information can be found in %AppData%\The ZAZ\Beacon\Default.beaconidentity on Windows or ~/Library/Application Support/The ZAZ/Beacon/Default.beaconidentity on Mac. The private key in that identity file NEVER leaves your computer. The identity controls ownership of the Beacon documents published online.</p>
	<p>These policies can be audited using the code in <a href="https://github.com/thommcgrath/Beacon">GitHub</a>. All relevant code, including website code and database schema, is included in the repository. If you don't believe my claims about user privacy, you are welcome to verify them yourself or ask a third party to do so.</p>
</div>
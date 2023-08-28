<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Privacy and Security');
?><h1 id="beacon-privacy-and-security">Beacon Privacy and Security</h1>
<h2 id="basic-summary">Basic Summary</h2>
<ul>
	<li>All user data is anonymous, even email addresses.</li>
	<li>Encryption is handled with 4096-bit RSA Public Key Cryptography.</li>
	<li>Beacon and its website are fully open source.</li>
</ul>
<h2 id="more-details">More Details</h2>
<h3 id="user-anonymity">User Anonymity</h3>
<p>Beacon stores only a single piece of identifiable information on each user: their username. Which of course, could be anything the user desires. User email addresses are stored as salted bcrypt hashes with k-anonymity. This allows email addresses to be confirmed during login, but cannot be reversed.</p>
<p>Beacon’s payment processor, Stripe, does store some personally identifiable information. Stripe’s privacy policy can be found at <a href="https://stripe.com/us/privacy">https://stripe.com/us/privacy</a>.</p>
<h3 id="user-security">User Security</h3>
<p>Upon first launch, Beacon generates a cryptographically secure 128-bit random number to use as the user’s UUID. This number is not based on any user or hardware information. Beacon also generates a 4096-bit RSA private key to use as proof of identity.</p>
<p>Unless the user chooses to disable community features when prompted at launch, Beacon will send the user’s UUID and public key to the Beacon server. This grants the user access to community features, such as the ability to publish documents to the community library. This user is fully anonymous.</p>
<p>If the user decides to create a login with Beacon, some additional data is shared with Beacon’s server. The user’s password is run through the PBKDF2 algorithm to generate a key to encrypt the user’s RSA <em>private</em> key with 256-bit AES CBC. Beacon’s database stores these encrypted private keys so they can be transported to other computers the user signs into. When signing into Beacon, the private key is delivered to the computer encrypted and decrypted on the computer, not on Beacon’s server.</p>
<h3 id="project-encryption">Project Encryption</h3>
<p>Some parts of a Beacon project are encrypted using the user’s private key, such as server information and user-defined parts of the <em>Custom Config</em> editor. If the user’s private key cannot decrypt information from a project, that information is not loaded by Beacon.</p>
<h3 id="analytics">Analytics</h3>
<p>There aren’t any. Beacon does not utilize analytics of any kind, even on the website.</p>
<h2 id="partner-privacy-policies">Partner Privacy Policies</h2>
<ul>
	<li><a href="https://stripe.com/us/privacy">Stripe</a>: Handles Beacon payments.</li>
	<li><a href="https://www.zendesk.com/company/agreements-and-terms/privacy-policy/">ZenDesk</a>: Used for web and in-app support tickets. Files submitted to from inside Beacon are end-to-end encrypted and cannot be viewed by ZenDesk employees.</li>
	<li><a href="https://bunny.net/privacy">Bunny.net</a>: Used for download hosting. Three days of anonymous download logs are stored.</li>
	<li><a href="https://haveibeenpwned.com/privacy">Have I Been Pwned</a>: During signup, passwords are anonymously checked against the world’s largest database of leaked passwords.</li>
	<li><a href="https://postmarkapp.com/privacy-policy">Postmark</a>: Emails sent by Beacon are routed through Postmark to reduce the chances of messages going to spam boxes.</li>
	<li><a href="https://wasabi.com/legal/privacy-policy/">Wasabi</a>: Used for long-term storage of user cloud files. Projects use their standard encryption techniques, everything else is end-to-end encrypted.</li>
</ul>

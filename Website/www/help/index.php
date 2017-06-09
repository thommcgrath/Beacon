<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Troubleshooting');
?><h1>Troubleshooting</h1>
<p>As much as Beacon attempts to be self-explaining, sometimes there are problems that require human interaction.</p>
<h3>Engrams are not updating</h3>
<div class="indent">
	<p>Beacon automatically updates its engram database every launch. However, there are scenarios that could prevent this from happening.</p>
	<p>First thing is first, manually update your engrams. <a href="/classes.php">Download the engrams</a>, then use &quot;Import&hellip;&quot; from the &quot;File&quot; menu to import the file into Beacon.</p>
	<p>Now on to actually solving the problem. Users on Windows 7 and Windows 8.0 (but not Windows 8.1 and newer) often have this issue because these versions do not have support for TLS 1.1 and 1.2 enabled, which Beacon requires. Normally, the Beacon installer will attempt to enable this support automatically, but this doesn't always work.</p>
	<p>See <a href="https://support.microsoft.com/en-gb/help/3140245/update-to-enable-tls-1.1-and-tls-1.2-as-a-default-secure-protocols-in-winhttp-in-windows">https://support.microsoft.com/en-gb/help/3140245/update-to-enable-tls-1.1-and-tls-1.2-as-a-default-secure-protocols-in-winhttp-in-windows</a> for more details and a solution.</p>
</div>
<h3>The ini file produced isn't what was expected</h3>
<div class="indent">
	<p>This is such a detailed subject that there is <a href="math.php">an entire separate page</a> just explaining how Beacon does its math. Though the short version of the story is that Beacon produces ini files intended for Ark to read them, not humans. The code it creates attempts to tell Ark about the author's intentions. This means sometimes doing weird things to make that a reality.</p>
</div>
<h3>Some more personal help</h3>
<div class="indent">
	<p>Get in touch. Bugs should be reported on <a href="/reportaproblem.php">the GitHub page</a>. Anybody can create an account and this is more helpful than email when it comes to bugs. General help inquiries should be sent to <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
</div>
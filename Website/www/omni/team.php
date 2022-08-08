<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconTemplate::SetTitle('Beacon for Teams');

?><h1>Beacon for Teams</h1>
<p class="notice-block notice-warning">Beacon for Teams requires Beacon 1.5, which is currently in testing.</p>
<p>Beacon for Teams is a way to share Beacon with other members of your admin team for a reduced price.</p>
<h3>What you need to know</h3>
<ul>
	<li>Child accounts are fully controlled by the parent account. The parent account may disable child accounts, reset their passwords, or even delete them. Child accounts are not able to reset their own password.</li>
	<li>Child accounts have full access to all parent account projects. New projects created by child accounts are owned by the parent account.</li>
	<li>Child accounts are able to deploy changes to all servers in the parent account projects.</li>
	<li>Disabled child accounts do not count against the purchased child account limit.</li>
	<li>Child accounts may not have child accounts of their own.</li>
	<li>This service is for sharing access to a team of admins only. Prohibited behaviors include, but are not limited to:
		<ul>
			<li>Selling child accounts.</li>
			<li>Creating child accounts for users who will not administer your servers.</li>
		</ul>
		These rules will be strictly enforced. Failure to respect the rules will result in termination of your Omni purchase and child accounts without a refund.</li>
</ul>
<h3>Getting started</h3>
<p>Team accounts may be purchased from <a href="/omni">the Buy page</a> under the &quot;Team Member Account:&quot; option. After an account has been purchased, use <a href="/account/#team">the Team control panel</a> to manage child accounts.</p>
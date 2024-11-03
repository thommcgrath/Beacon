<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconTemplate::SetTitle('Update Plan FAQ');

?>
<h1>Beacon Update Plan FAQ</h1>
<h2>How does Beacon’s update plan work?</h2>
<p class="indent">When you buy a license for Beacon Omni that uses an update plan, your license will be valid forever in any version of Beacon that was released while your update plan is active.</p>
<h2>Does that mean I lose access to Beacon Omni after updates are automatically installed?</h2>
<p class="indent">Beacon <strong>does</strong> use an automatic updater, but it <strong>will not</strong> automatically update to a version that is not compatible with all of your licenses. However, you can still manually update Beacon by downloading the latest version from the website or using the Check for Updates option.</p>
<h2>How do I download older versions of Beacon?</h2>
<p class="indent">From the <a href="/account/#omni">Omni page of your account control panel</a>, you can always download the latest version of Beacon that your update plan includes. If your license doesn’t specify a version, it hasn’t expired yet. In such cases, you should visit the <a href="/download/">regular download page</a> to download Beacon.</p>
<h2>How do I turn off auto renewal of my update plan?</h2>
<p class="indent">Beacon doesn’t provide automatic renewals for update plans, so there’s no option to disable them.</p>
<h2>What if I put off renewing my update plan?</h2>
<p class="indent">There’s no penalty for waiting to renew your plan. For instance, if your plan is set to expire on March 1st, 2025, and you don’t renew until July 1st, 2025, your new expiration date will be July 1st, 2026. Similarly, if you renew early, your new expiration date will be a year from the old expiration date. The new expiration date is always calculated from the renewal date or the old expiration date, whichever is later.</p>
<h2>Shouldn’t bug fixes be included?</h2>
<p class="indent">Yes, whenever possible. Beacon version numbers consist of four components: major, minor, feature, and bugfix versions. For instance, in the version number 1.2.3.4, the major version is 1, the minor version is 2, the feature version is 3, and the bugfix version is 4. <strong>Even if an update plan has expired, all bugfix versions associated with a feature version are still covered.</strong></p>
<p class="indent">For example, let’s say version 2.3.1 was released on October 1st, an update plan expired on October 2nd, and then 2.3.1.1 was released on October 3rd. In this scenario, version 2.3.1.1 is still covered by the update plan. However, updating to version 2.3.2 or later would necessitate a renewal of your update plan.</p>
<p class="indent">The intention is to include fixes in updates, but new features require a renewal. However, there comes a point when this becomes impractical. Once a new feature update is released, there will be no more bug fixes for the older versions. It would become excessively costly to port fixes back to older versions. Therefore, while the intention is to always include fixes, there will be instances when fixes are part of a version that your update plan doesn’t cover.</p>

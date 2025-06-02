<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

use BeaconAPI\v4\{Application, DeviceAuthFlow};

header('Cache-Control: no-cache');
BeaconCommon::StartSession();
BeaconTemplate::SetTitle('Beacon Login');
BeaconTemplate::SetBodyClass('purple');
BeaconTemplate::AddHeaderLine('<link rel="canonical" href="' . BeaconCommon::AbsoluteUrl('/account/device') . '">');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

if (array_key_exists('complete', $_GET)) {
	$appId = $_GET['appId'];
	$application = Application::Fetch($appId);
	?><div id="login_container">
	<h1>Beacon Login</h1>
	<p>You have authorized <strong><?php echo htmlentities($application->Name()); ?></strong> to access your Beacon data. You can now close this tab.</p>
</div>
<?php
	return;
}

$deviceCode = $_GET['code'] ?? '';
if (empty($deviceCode) === false) {
	$flow = DeviceAuthFlow::Fetch($deviceCode);
	if (is_null($flow) === false) {
		$flowId = $flow->FlowId();
		BeaconCommon::Redirect(BeaconCommon::AbsoluteUrl('/account/login?flow_id='. urlencode($flowId)));
	}
}

?>
<div id="login_container">
	<h1>Beacon Login</h1>
	<?php BeaconLogin::Show(['needsDeviceCode' => true]); ?>
</div>

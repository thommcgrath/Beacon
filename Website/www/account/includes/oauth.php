<?php

use BeaconAPI\v4\OAuth;

$nitradoToken = OAuth::Lookup($user->UserId(), OAuth::ProviderNitrado);
$nitradoServiceName = 'Nitrado';
if (is_null($nitradoToken) === false) {
	$nitradoUserDetails = $nitradoToken->ProviderSpecific();
	$nitradoServiceName = $nitradoUserDetails['user']['username'] . ' (' . $nitradoUserDetails['user']['id'] . ')';
}

?><div class="visual-group">
	<div class="services-grid">
		<div class="service service-nitrado">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('nitrado-color.svg'); ?>" alt="Nitrado"></div>
			<div class="service-name"><?php echo htmlentities($nitradoServiceName); ?></div>
			<div class="service-action"><button class="yellow" beacon-provider="nitrado" beacon-status="<?php echo is_null($nitradoToken) ? 'disconnected' : 'connected'; ?>"><?php echo is_null($nitradoToken) ? 'Connect' : 'Disconnect'; ?></button></div>
		</div>
	</div>
</div>
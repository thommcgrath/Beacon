<?php

use BeaconAPI\v4\OAuth;

$connectedServices = OAuth::Lookup($user->UserId());
if (count($connectedServices) > 0) {
	echo '<div class="visual-group"><h3>Connected Services</h3><div class="services-grid">';
	
	foreach ($connectedServices as $service) {
		$provider = $service->Provider();
		$providerLower = strtolower($provider);
		$username = $provider;
		$buttonClass = '';
		switch ($provider) {
		case OAuth::ProviderNitrado:
			$buttonClass = 'yellow';
			$details = $service->ProviderSpecific();
			$username = htmlentities($details['user']['username']) . ' <span class="service-uid">(' . htmlentities($details['user']['id']) . ')</span>';
			break;
		}
		
		echo '<div class="service service-' . $providerLower . '">';
		echo '<div class="service-logo"><img src="' . BeaconCommon::AssetURI($providerLower . '-color.svg') . '" alt="' . $provider . '"></div>';
		echo '<div class="service-name">' . $username . '</div>';
		echo '<div class="service-action"><button class="' . $buttonClass . '" beacon-provider="' . $providerLower . '" beacon-token-id="' . htmlentities($service->TokenId()) . '">Disconnect</button></div>';
		echo '</div>';
	}
	
	echo '</div></div>';
}

?><div class="visual-group">
	<h3>Available Services</h3>
	<div class="services-grid">
		<div class="service service-nitrado inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('nitrado-color.svg'); ?>" alt="Nitrado"></div>
			<div class="service-name">Nitrado</div>
			<div class="service-action"><button beacon-provider="nitrado" beacon-token-id="">Connect</button></div>
		</div>
	</div>
</div>
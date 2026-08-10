<?php

use BeaconAPI\v4\ServiceToken;

$connectedServices = ServiceToken::Lookup($user->UserId());
if (count($connectedServices) > 0) {
	echo '<div class="visual-group"><h3>Connected Services</h3><div class="services-grid">';

	foreach ($connectedServices as $service) {
		$provider = $service->Provider();
		$providerLower = strtolower($provider);
		$providerSimplified = $providerLower;
		if ($providerSimplified === 'gameserverapp.com') {
			$providerSimplified = 'gameserverapp';
		}
		$type = $service->Type();
		$username = $provider;
		$buttonClass = 'red';
		$buttonCaption = $type === ServiceToken::TypeOAuth ? 'Disconnect' : 'Discard';
		$serviceName = '';
		switch ($provider) {
		case ServiceToken::ProviderNitrado:
			$details = $service->ProviderSpecific();
			$username = htmlentities($details['user']['username']) . ' <span class="service-uid">(' . htmlentities($details['user']['id']) . ')</span>';
			$serviceName = $details['user']['username'];

			if (array_key_exists('tokenName', $details)) {
				$serviceName = $details['tokenName'];
				$username = htmlentities($serviceName) . '<br>' . $username;
			}
			break;
		case ServiceToken::ProviderGameServerApp:
		case ServiceToken::ProviderASAManager:
		case ServiceToken::ProviderGameServersPanel:
		case ServiceToken::ProviderBeaconHostingAPI:
			$details = $service->ProviderSpecific();
			$username = htmlentities($details['tokenName']);
			$serviceName = $details['tokenName'];
			break;
		}

		switch ($provider) {
		case ServiceToken::ProviderGameServersPanel:
			$imageNames = ['gameserverspanel.webp', 'gameserverspanel@2x.webp', 'gameserverspanel@3x.webp'];
			break;
		default:
			$imageNames = [$providerSimplified . '-color.svg'];
		}

		echo '<div class="service service-' . $providerSimplified . ' active">';
		if (count($imageNames) === 1) {
			echo '<div class="service-logo"><img src="' . BeaconCommon::AssetURI($providerSimplified . '-color.svg') . '" alt="' . $provider . '"></div>';
		} else {
			echo '<div class="service-logo"><img src="' . BeaconCommon::AssetURI($imageNames[0]) . '" srcset="' . BeaconCommon::AssetURI($imageNames[0]) . ' 1x, ' . BeaconCommon::AssetURI($imageNames[1]) . ' 2x, ' . BeaconCommon::AssetURI($imageNames[2]) . ' 3x" alt="' . $provider . '"></div>';
		}
		echo '<div class="service-name">' . $username . '</div>';
		if ($service->NeedsReplacing()) {
			echo '<div class="service-error">This service is no longer usable due to an authentication error and should be replaced.</div>';
		}
		echo '<div class="service-action"><div class="button-group"><button class="' . $buttonClass . '" beacon-provider="' . $providerLower . '" beacon-provider-type="' . strtolower($service->Type()) . '" beacon-token-id="' . htmlentities($service->TokenId()) . '" beacon-token-name="' . htmlentities($serviceName) . '">' . htmlentities($buttonCaption) . '</button></div></div>';
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
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="<?php echo strtolower(ServiceToken::ProviderNitrado); ?>" beacon-provider-type="oauth" beacon-token-id="">Connect</button><button beacon-provider="nitrado" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
		<div class="service service-gameserverapp inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('gameserverapp-black.svg'); ?>" alt="GameServerApp"></div>
			<div class="service-name">GameServerApp.com</div>
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="<?php echo strtolower(ServiceToken::ProviderGameServerApp); ?>" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
		<div class="service service-asamanager inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('asamanager-color.svg'); ?>" alt="ASA Manager"></div>
			<div class="service-name">ASA Manager</div>
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="<?php echo strtolower(ServiceToken::ProviderASAManager); ?>" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
		<div class="service service-gameserverspanel inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('gameserverspanel.webp'); ?>" srcset="<?php echo BeaconCommon::AssetURI('gameserverspanel.webp'); ?> 1x, <?php echo BeaconCommon::AssetURI('gameserverspanel@2x.webp'); ?> 2x, <?php echo BeaconCommon::AssetURI('gameserverspanel.png@3x.webp'); ?> 3x" alt="GameServersPanel"></div>
			<div class="service-name">GameServersPanel</div>
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="<?php echo strtolower(ServiceToken::ProviderGameServersPanel); ?>" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
		<div class="service service-beaconhostingapi inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('beaconhostingapi-color.svg'); ?>" alt="Beacon Hosting API"></div>
			<div class="service-name">Beacon Open Hosting API</div>
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="<?php echo strtolower(ServiceToken::ProviderBeaconHostingAPI); ?>" beacon-provider-type="static" beacon-token-id="">Add Host</button></div></div>
		</div>
	</div>
</div>
<div class="hidden"><input type="hidden" id="static-token-provider-field" value=""></div>
<?php

BeaconTemplate::StartModal('static-token-modal');
?><div class="modal-content">
	<div class="title-bar">Add Token</div>
	<div class="content">
		<p class="text-center" id="static-token-help-field"></p>
		<p class="text-center hidden notice-block notice-warning" id="static-token-error-field"></p>
		<p class="text-center" id="static-token-generate-space"><a class="button blue" href="" id="static-token-generate-link" target="_blank">Generate A Token</a></p>
		<div class="floating-label"><input type="text" id="static-token-name-field" class="text-field" placeholder="Token Name"><label for="static-token-name-field">Token Name</label></div>
		<div class="floating-label" id="static-token-url-div"><input type="text" id="static-token-url-field" class="text-field" placeholder="Host Discovery Endpoint"><label for="static-token-url-field">Host Discovery Endpoint</label></div>
		<div class="floating-label"><textarea id="static-token-token-field" class="text-field" placeholder="Token" rows="4"></textarea><label for="static-token-token-field">Token</label></div>
	</div>
	<div class="button-bar">
		<div class="left">&nbsp;</div>
		<div class="middle">&nbsp;</div>
		<div class="right">
			<div class="button-group">
				<button id="static-token-cancel-button">Cancel</button>
				<button id="static-token-action-button" class="default" disabled>Add</button>
			</div>
		</div>
	</div>
</div><?php
BeaconTemplate::FinishModal();
?>

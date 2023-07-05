<?php

use BeaconAPI\v4\ServiceToken;

$connectedServices = ServiceToken::Lookup($user->UserId());
if (count($connectedServices) > 0) {
	echo '<div class="visual-group"><h3>Connected Services</h3><div class="services-grid">';
	
	foreach ($connectedServices as $service) {
		$provider = $service->Provider();
		$providerLower = strtolower($provider);
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
			$details = $service->ProviderSpecific();
			$username = htmlentities($details['tokenName']);
			$serviceName = $details['tokenName'];
			break;
		}
		
		echo '<div class="service service-' . $providerLower . '">';
		echo '<div class="service-logo"><img src="' . BeaconCommon::AssetURI($providerLower . '-color.svg') . '" alt="' . $provider . '"></div>';
		echo '<div class="service-name">' . $username . '</div>';
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
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="nitrado" beacon-provider-type="oauth" beacon-token-id="">Connect</button><button beacon-provider="nitrado" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
		<div class="service service-gameserverapp inactive">
			<div class="service-logo"><img src="<?php echo BeaconCommon::AssetURI('gameserverapp-color.svg'); ?>" alt="GameServerApp"></div>
			<div class="service-name">GameServerApp.com</div>
			<div class="service-action"><div class="button-group"><button class="blue" beacon-provider="gameserverapp" beacon-provider-type="static" beacon-token-id="">Add Token</button></div></div>
		</div>
	</div>
</div>
<?php

BeaconTemplate::StartModal('static-token-modal');
?><div class="modal-content">
	<div class="title-bar">Add Token</div>
	<div class="content">
		<div class="hidden"><input type="hidden" id="static-token-provider-field" value=""></div>
		<p class="text-center"><a class="button blue" href="" id="static-token-generate-link" target="_blank">Generate A Token</a></p>
		<p class="text-center hidden" id="static-token-help-field"></p>
		<p class="text-center hidden notice-block notice-warning" id="static-token-error-field"></p>
		<div class="floating-label"><input type="text" id="static-token-name-field" class="text-field" placeholder="Token Name"><label for="static-token-name-field">Token Name</label></div>
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

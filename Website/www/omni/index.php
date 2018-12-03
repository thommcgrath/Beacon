<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::AddHeaderLine('<script src="https://js.stripe.com/v3/"></script>');
BeaconTemplate::StartScript();

BeaconCommon::StartSession();
if (!isset($_SESSION['client_reference_id'])) {
	$client_reference_id = BeaconCommon::GenerateUUID();
	$_SESSION['client_reference_id'] = $client_reference_id;
} else {
	$client_reference_id = $_SESSION['client_reference_id'];
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT stripe_sku FROM products WHERE product_id = $1', '972f9fc5-ad64-4f9c-940d-47062e705cc5');
if ($results->RecordCount() != 1) {
	throw new Exception('Unable to find product');
	exit;
}
$omni_sku = $results->Field('stripe_sku');
?>
<script>
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('buy-button').addEventListener('click', function() {
		this.disabled = true;
		
		var stripe = Stripe(<?php echo json_encode(BeaconCommon::GetGlobal('Stripe_Public_Key')); ?>, {
			betas: ['checkout_beta_3']
		});
		
		stripe.redirectToCheckout({
			items: [{sku: <?php echo json_encode($omni_sku); ?>, quantity: 1}],
			successUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/welcome/')); ?>,
			cancelUrl: <?php echo json_encode(BeaconCommon::AbsoluteURL('/omni/')); ?>,
			clientReferenceId: <?php echo json_encode($client_reference_id); ?>
		}).then(function (result) {
			if (result.error) {
				var displayError = document.getElementById('error-message');
				displayError.textContent = result.error.message;
			}
		});
	});
});
</script>
<?php
BeaconTemplate::FinishScript();

echo $client_reference_id;

?><div id="error-message"></div>
<button id="buy-button">Buy Omni</button>
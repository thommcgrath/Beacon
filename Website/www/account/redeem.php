<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_REQUEST['code'])) {
	$code = substr($_REQUEST['code'], 0, 9);
} else {
	$code = '';
}

BeaconCommon::StartSession();
$session = BeaconSession::GetFromCookie();
$is_logged_in = is_null($session) === false;

header('Cache-Control: no-cache');

$database = BeaconCommon::Database();

BeaconTemplate::StartStyles(); ?>
<style>

#redeem_form {
	width: 600px;
	max-width: 100%;
	margin-left: auto;
	margin-right: auto;
}	

</style><?php
BeaconTemplate::FinishStyles();
	
$process_step = 'start';
if (isset($_REQUEST['process'])) {
	$process_step = strtolower($_REQUEST['process']);
}

switch ($process_step) {
case 'redeem-final':
case 'redeem-confirm':
	$confirmed = $process_step === 'redeem-confirm';
	
	if ($is_logged_in === false) {
		$return = BeaconCommon::AbsoluteURL('/account/redeem.php?code=' . urlencode($code) . '&process=redeem-confirm');
		BeaconCommon::Redirect('/account/login/?return=' . urlencode($return));
	}
	
	$results = $database->Query('SELECT redemption_date, product_id FROM gift_codes WHERE code = $1;', $code);
	if ($results->RecordCount() === 0 || is_null($results->Field('redemption_date')) === false) {
		OutputRedeemForm('The gift code does not exist or was already redeemed.');
	}
	
	$user = BeaconUser::GetByUserID($session->UserID());
	if ($user->IsBanned()) {
		BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
		BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw');
	}
	
	$user = BeaconUser::GetByUserID($session->UserID());
	if ($process_step === 'redeem-final') {
		// Actually redeem it
		if ($user->IsBanned()) {
			BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
			BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw');
		}
		
		$email_id = $user->EmailID();
		$product_id = $results->Field('product_id');
		$results = $database->Query('SELECT updates_length FROM products WHERE product_id = $1;', $product_id);
		$is_perpetual = is_null($results->Field('updates_length'));
		if ($is_perpetual) {
			$results = $database->Query('SELECT expiration, product_name FROM purchased_products WHERE purchaser_email = $1 AND product_id = $2;', $email_id, $product_id);
			if ($results->RecordCount() === 1 && is_null($results->Field('expiration')) === true) {
				OutputRedeemForm('You already own a perpetual license for ' . $results->Field('product_name') . ', there is no need to redeem another!');
			}
		}
		
		$database->BeginTransaction();
		$redemption_purchase_id = BeaconShop::CreateGiftPurchase($email_id, $product_id, 1, 'Redeemed gift code: ' . $code, true);
		$database->Query('UPDATE gift_codes SET redemption_purchase_id = $2, redemption_date = CURRENT_TIMESTAMP WHERE code = $1;', $code, $redemption_purchase_id);
		$database->Commit();
		
		echo '<div id="redeem_form"><p class="text-center"><span class="text-blue">Gift code redeemed!</span><br><a href="/account/#omni">Activation instructions</a> are available if you need them.</p></div>';
	} else {
		// Show an "are you sure" page
		$results = $database->Query('SELECT product_name FROM products INNER JOIN gift_codes ON (gift_codes.product_id = products.product_id) WHERE gift_codes.code = $1;', $code);
		$product_name = $results->Field('product_name');
		
		?><h1>Redeem a Beacon Gift Code</h1>
		<div id="redeem_form">
			<p>Redeem code <?php echo htmlentities($code); ?> for &quot;<?php echo htmlentities($product_name); ?>&quot; to account <?php echo htmlentities($user->Username()) . '<span class="text-lighter">#' . htmlentities($user->Suffix()) . '</span>'; ?>?</p>
			<form action="redeem" method="post">
				<input type="hidden" name="process" value="redeem-final">
				<input type="hidden" name="code" value="<?php echo htmlentities($code); ?>">
				<p class="text-center"><a href="/redeem" class="button">No</a><input type="submit" value="Yes"></p>
			</form>
		</div><?php
	}
	
	break;
default:
	OutputRedeemForm();
	break;
}

function OutputRedeemForm(string $error = '') {
	global $code, $is_logged_in;
	
?><h1>Redeem a Beacon Gift Code</h1>
<div id="redeem_form">
	<form action="redeem" method="post">
		<input type="hidden" name="process" value="redeem-confirm">
		<p>Got a Beacon gift code? Redeem it here!</p>
		<?php if (empty($error) === false) { ?><p class="text-center text-red"><?php echo htmlentities($error); ?></p><?php } ?>
		<p><input type="text" name="code" placeholder="Code" minlength="9" maxlength="9" value="<?php echo htmlentities($code); ?>"></p>
		<?php if ($is_logged_in) { ?>
		<p class="text-right"><input type="submit" value="Redeem"></p>
		<?php } else { ?>
		<p class="text-right bold">You will be be asked to log in or create an account to redeem this code.</p>
		<p class="text-right"><input type="submit" value="Sign In and Redeem"></p>
		<?php } ?>
	</form>
</div>
<?php
	exit;
}

?>

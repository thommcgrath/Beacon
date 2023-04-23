<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_REQUEST['code'])) {
	$code = substr($_REQUEST['code'], 0, 9);
} else {
	$code = '';
}

BeaconCommon::StartSession();
$session = BeaconSession::GetFromCookie();
$user = is_null($session) ? null : $session->User();

header('Cache-Control: no-cache');

$database = BeaconCommon::Database();

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));
	
$process_step = 'start';
if (isset($_REQUEST['process'])) {
	$process_step = strtolower($_REQUEST['process']);
}

?><div id="redeem_form" class="reduced-width">
	<h1>Beacon Gift Codes</h1>
	<?php
	
	switch ($process_step) {
	case 'redeem-final':
	case 'redeem-confirm':
		RedeemCode($code, $process_step === 'redeem-final');
		break;
	default:
		ShowForm($code);
		break;
	}
	
	?>
</div><?php

function RedeemCode(string $code, bool $confirmed): void {
	global $user;
	
	if (is_null($user)) {
		$return = BeaconCommon::AbsoluteURL('/account/redeem/' . urlencode($code) . '?process=redeem-confirm');
		BeaconCommon::Redirect('/account/login/?return=' . urlencode($return));
		return;
	}
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT redemption_date FROM public.gift_codes WHERE code = $1;', $code);
	if ($results->RecordCount() === 0 || is_null($results->Field('redemption_date')) === false) {
		LogRedeemAttempt($code, $user->UserID(), false);
		ShowForm($code, 'The gift code does not exist or was already redeemed.');
		return;
	}
	
	if ($user->IsBanned()) {
		LogRedeemAttempt($code, $user->UserID(), false);
		BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
		BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw', false);
		return;
	}
	
	if ($confirmed) {
		// Redeem the gift code
		
	} else {
		// Show confirmation
		$results = $database->Query('SELECT products.product_id, products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = $1;', $code);
	}
}

function ShowForm(string $code, ?string $error = null): void {
	global $user;
	
	echo '<form action="/account/redeem" method="post"><input type="hidden" name="process" value="redeem-confirm"><p>Got a Beacon gift code? Redeem it here!</p>';
	
	if (empty($error) === false) {
		echo '<p class="text-center text-red">' . htmlentities($error) . '</p>';
	}
	
	echo '<div class="floating-label"><input type="text" class="text-field" name="code" placeholder="Code" minlength="9" maxlength="9" value="' . htmlentities($code) . '"><label>Gift Code</label></div>';

	if (is_null($user)) {
		echo '<p class="text-right bold">You will be be asked to log in or create an account to redeem this code.</p>';
		echo '<p class="text-right"><input type="submit" value="Sign In and Redeem"></p>';
	} else {
		echo '<p class="text-right"><input type="submit" value="Redeem"></p>';
	}
}

/*switch ($process_step) {
case 'redeem-final':
case 'redeem-confirm':
	$confirmed = $process_step === 'redeem-confirm';
	
	if ($is_logged_in === false) {
		$return = BeaconCommon::AbsoluteURL('/account/redeem/' . urlencode($code) . '?process=redeem-confirm');
		BeaconCommon::Redirect('/account/login/?return=' . urlencode($return));
	}
	$user = BeaconUser::GetByUserID($session->UserID());
	
	$results = $database->Query('SELECT redemption_date FROM public.gift_codes WHERE code = $1;', $code);
	if ($results->RecordCount() === 0 || is_null($results->Field('redemption_date')) === false) {
		LogRedeemAttempt($code, $user->UserID(), false);
		OutputRedeemForm('The gift code does not exist or was already redeemed.');
	}
	
	if ($user->IsBanned()) {
		LogRedeemAttempt($code, $user->UserID(), false);
		BeaconCommon::PostSlackMessage('Banned account ' . $user->UserID() . ' tried to redeem gift code ' . $code . '.');
		BeaconCommon::Redirect('https://www.youtube.com/watch?v=sKbP-M8vVtw', false);
	}
	
	$user = BeaconUser::GetByUserID($session->UserID());
	if ($process_step === 'redeem-final') {
		$email_id = $user->EmailID();
		$product_id = $results->Field('product_id');
		$results = $database->Query('SELECT updates_length FROM products WHERE product_id = $1;', $product_id);
		$is_perpetual = is_null($results->Field('updates_length'));
		if ($is_perpetual) {
			$results = $database->Query('SELECT expiration, product_name FROM purchased_products WHERE purchaser_email = $1 AND product_id = $2;', $email_id, $product_id);
			if ($results->RecordCount() === 1 && is_null($results->Field('expiration')) === true) {
				LogRedeemAttempt($code, $user->UserID(), false);
				OutputRedeemForm('You already own a perpetual license for ' . $results->Field('product_name') . ', there is no need to redeem another!');
			}
		}
		
		$database->BeginTransaction();
		$redemption_purchase_id = BeaconShop::CreateGiftPurchase($email_id, $product_id, 1, 'Redeemed gift code: ' . $code, true);
		$database->Query('UPDATE gift_codes SET redemption_purchase_id = $2, redemption_date = CURRENT_TIMESTAMP WHERE code = $1;', $code, $redemption_purchase_id);
		LogRedeemAttempt($code, $user->UserID(), true);
		$database->Commit();
		
		echo '<div id="redeem_form"><p class="text-center"><span class="text-blue">Gift code redeemed!</span><br><a href="/account/#omni">Activation instructions</a> are available if you need them.</p></div>';
	} else {
		// Show an "are you sure" page
		$results = $database->Query('SELECT products.product_id, products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = $1;', $code);
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
	
?><div class="reduced-width">
	<h1>Redeem a Beacon Gift Code</h1>
	<div id="redeem_form">
		
	</div>
</div>
<?php
	exit;
}*/

function LogRedeemAttempt(string $code, string $user_id, bool $success): void {
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO gift_code_log (code, user_id, source_ip, success) VALUES ($1, $2, $3, $4);', $code, $user_id, BeaconCommon::RemoteAddr(true), $success);
	$database->Commit();
}

?>

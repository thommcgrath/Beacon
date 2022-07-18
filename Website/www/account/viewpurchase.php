<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

if (isset($_GET['purchase_id']) === false) {
	BeaconCommon::Redirect('/account/#omni');
}

$purchase_id = $_GET['purchase_id'];
if (BeaconCommon::IsUUID($purchase_id) === false) {
	BeaconCommon::Redirect('/account/#omni');
}

$database = BeaconCommon::Database();
$purchase = $database->Query('SELECT EXTRACT(epoch FROM purchase_date) AS purchase_date, subtotal, discount, tax, total_paid, currency, refunded, notes FROM purchases WHERE purchase_id = $1;', $purchase_id);
if ($purchase->RecordCount() === 0) {
	BeaconCommon::Redirect('/account/#omni');
}

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

$purchase_seconds = intval($purchase->Field('purchase_date'));
$purchase_currency = $purchase->Field('currency');
$purchase_subtotal = BeaconShop::FormatPrice($purchase->Field('subtotal'), $purchase_currency, false);
$purchase_discount = BeaconShop::FormatPrice($purchase->Field('discount'), $purchase_currency, false);
$purchase_tax = BeaconShop::FormatPrice($purchase->Field('tax'), $purchase_currency, false);
$purchase_total = BeaconShop::FormatPrice($purchase->Field('total_paid'), $purchase_currency, false);
$purchase_refunded = $purchase->Field('refunded');
$purchase_notes = $purchase->Field('notes');

echo '<h1>Purchase on ' . date('F jS Y', $purchase_seconds) . ' at ' . date('g:i:s A e', $purchase_seconds);
if ($purchase_refunded) {
	echo '<span class="tag red">Refunded</span>';
}
echo '</h1>';

if (empty($purchase_notes) === false) {
	echo '<p>' . htmlentities($purchase_notes) . '</p>';
}

echo '<table class="generic">';
echo '<thead><tr><th class="w-40">Product</th><th class="w-20">Unit Price</th><th class="w-20">Discount</th><th class="w-20">Total</th></tr></thead>';
$items = $database->Query('SELECT products.product_name, purchase_items.unit_price, purchase_items.discount, purchase_items.quantity, purchase_items.line_total - purchase_items.tax AS line_total_less_tax, purchase_items.currency FROM purchase_items INNER JOIN products ON (purchase_items.product_id = products.product_id) WHERE purchase_id = $1;', $purchase_id);
while ($items->EOF() === false) {
	$product_name = $items->Field('product_name');
	$quantity = intval($items->Field('quantity'));
	if ($quantity > 1) {
		$product_name = $quantity . ' x ' . $product_name;
	}
	$currency = $items->Field('currency');
	$unit_price = BeaconShop::FormatPrice($items->Field('unit_price'), $currency, false);
	$discount = BeaconShop::FormatPrice($items->Field('discount'), $currency, false);
	$total = BeaconShop::FormatPrice($items->Field('line_total_less_tax'), $currency, false);
	
	echo '<tr><td>' . htmlentities($product_name) . '</td><td class="text-right">' . htmlforprice($unit_price, $currency) . '</td><td class="text-right">' . htmlforprice($discount, $currency) . '</td><td class="text-right">' . htmlforprice($total, $currency) . '</td></tr>';
	
	$items->MoveNext();
}
echo '<thead><tr><th class="w-40">&nbsp;</th><th class="w-20">&nbsp;</th><th class="w-20">&nbsp;</th><th class="w-20">Total</th></tr></thead>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Subtotal</td><td class="text-right">' . htmlforprice($purchase_subtotal, $purchase_currency) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Discount</td><td class="text-right">' . htmlforprice($purchase_discount, $purchase_currency) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Tax</td><td class="text-right">' . htmlforprice($purchase_tax, $purchase_currency) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Total</td><td class="bold text-right">' . htmlforprice($purchase_total, $purchase_currency) . '</td></tr>';
echo '</table>';

function htmlforprice(string $price, string $currency) {
	return htmlentities($price) . '<span class="desktop-only">&nbsp;' . htmlentities($currency) . '</span>';
}

?>

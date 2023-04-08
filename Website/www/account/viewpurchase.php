<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Cache-Control: no-cache');

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
BeaconTemplate::LoadGlobalize();

BeaconTemplate::StartScript();
?><script>
BeaconCurrency.currencyCode = <?php echo json_encode($purchase->Field('currency')); ?>;
</script><?php
BeaconTemplate::FinishScript();

$purchase_seconds = intval($purchase->Field('purchase_date'));
$purchase_currency = $purchase->Field('currency');
$purchase_subtotal = $purchase->Field('subtotal');
$purchase_discount = $purchase->Field('discount');
$purchase_tax = $purchase->Field('tax');
$purchase_total = $purchase->Field('total_paid');
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
	$unit_price = $items->Field('unit_price');
	$discount = $items->Field('discount');
	$total = $items->Field('line_total_less_tax');
	
	echo '<tr><td>' . htmlentities($product_name) . '</td><td class="text-right formatted-price">' . htmlentities($unit_price) . '</td><td class="text-right formatted-price">' . htmlentities($discount) . '</td><td class="text-right formatted-price">' . htmlentities($total) . '</td></tr>';
	
	$items->MoveNext();
}
echo '<thead><tr><th class="w-40">&nbsp;</th><th class="w-20">&nbsp;</th><th class="w-20">&nbsp;</th><th class="w-20">Total</th></tr></thead>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Subtotal</td><td class="text-right formatted-price">' . htmlentities($purchase_subtotal) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Discount</td><td class="text-right formatted-price">' . htmlentities($purchase_discount) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Tax</td><td class="text-right formatted-price">' . htmlentities($purchase_tax) . '</td></tr>';
echo '<tr><td>&nbsp;</td><td>&nbsp;</td><td class="bold text-right">Total</td><td class="bold text-right formatted-price">' . htmlentities($purchase_total) . '</td></tr>';
echo '</table>';

?>

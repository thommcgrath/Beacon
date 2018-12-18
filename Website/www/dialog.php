<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

BeaconTemplate::StartScript();
?>
<script>

document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('show_dialog_button').addEventListener('click', function() {
		dialog.show('This is the message', 'And this is the explanation');
	});
});

</script>
<?php
BeaconTemplate::FinishScript();

?><button id="show_dialog_button">Alert</button>
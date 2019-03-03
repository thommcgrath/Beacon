<?php
	
if (!isset($with_search_button)) {
	$with_search_button = false;
}

BeaconTemplate::StartStyles(); ?>
<style>

#support_search_block {
	text-align: center;
	margin-bottom: 40px;
}

<?php if ($with_search_button) { ?>#support_search_field {
	max-width: 60%;
	margin-right: 15px;
}<?php } ?>

#support_search_button {
	vertical-align: baseline;
}

</style>
<?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
	
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('support_search_form').addEventListener('submit', function(ev) {
		var query = document.getElementById('support_search_field').value;
		var url = '/help/search/' + encodeURIComponent(query);
		
		window.location = url;
		this.disabled = true;
		ev.preventDefault();
	});
});

</script>
<?php
BeaconTemplate::FinishScript();

?><div id="support_search_block">
	<form action="/help/search.php" method="get" id="support_search_form">
		<input type="search" placeholder="Search For Help" name="query" id="support_search_field" recents="0" value="<?php if (isset($_GET['query'])) { echo htmlentities($_GET['query']); } ?>"><?php if ($with_search_button) { ?><input type="submit" value="Search" id="support_search_button"><?php } ?>
	</form>
</div>
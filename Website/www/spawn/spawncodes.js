window.addEventListener('load', function() {
	var rows = document.getElementsByClassName('beacon-engram');
	for (var i = 0, len = rows.length; i < len; i++) {
		var row = rows[i];
		var links = row.getElementsByClassName('beacon-engram-copy');
		if (links.length === 1) {
			links[0].addEventListener('click', function(event) {
				var classstring = event.target.getAttribute('beacon-class');
				var cell = document.getElementById('spawn_' + classstring.toLowerCase());
				if (cell) {
					try {
						clipboard.writeText(cell.value);
						
						event.target.innerText = 'Copied!';
						event.target.disabled = true;
						setTimeout(function() {
							event.target.innerText = 'Copy';
							event.target.disabled = false;
						}, 3000);
					} catch (err) {
						alert('Looks like this browser does not support automatic copy. You will need to do it yourself.');
					}
				} else {
					console.log('Cell spawn_' + classstring.toLowerCase() + ' was not found');
				}
			});
		} else {
			debugger;
		}
	}
	
	var searchField = document.getElementById('beacon-filter-field');
	if (searchField) {
		searchField.lastValue = searchField.value;
		
		var fn = function(event) {
			var value = event.target.value.toLowerCase();
			if (value == event.target.lastValue) {
				return;
			}
			
			event.target.lastValue = value;
			event.stopPropagation();
			
			for (var i = 0, len = rows.length; i < len; i++) {
				var row = rows[i];
				var label = row.getAttribute('beacon-label');
				if (label.indexOf(value) > -1) {
					row.style.display = 'table-row';
				} else {
					row.style.display = 'none';
				}
			}
		};
		
		searchField.addEventListener('change', fn);
		searchField.addEventListener('keyup', fn);
		searchField.addEventListener('paste', fn);
		searchField.addEventListener('input', fn);
	}
});
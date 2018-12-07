document.addEventListener('DOMContentLoaded', function() {
	search.init();
	sidebar.init();
});

var sidebar = {
	init: function () {
		var hamburger = document.getElementById('header_hamburger');
		if (hamburger) {
			hamburger.addEventListener('click', function(event) {
				sidebar.show();
			});
		}
		
		var darkener = document.getElementById('darkener');
		if (darkener) {
			darkener.addEventListener('click', function(event) {
				sidebar.hide();
			});
		}
	},
	show: function() {
		var darkener = document.getElementById('darkener');
		var sidebar = document.getElementById('sidebar');
		if (sidebar && darkener) {
			darkener.className = 'exist';
			sidebar.className = 'exist';
			setTimeout(function() {
				darkener.className = 'exist visible';
				sidebar.className = 'exist visible';
			}, 1);
		}
	},
	hide: function() {
		var darkener = document.getElementById('darkener');
		var sidebar = document.getElementById('sidebar');
		if (sidebar && darkener) {
			darkener.className = 'exist';
			sidebar.className = 'exist';
			setTimeout(function() {
				darkener.className = '';
				sidebar.className = '';
			}, 200);
		}
	}
};

var search = {
	timeout: 0,
	list: null,
	init: function () {
		var search_field = document.getElementById('sidebar_search_field');
		if (search_field) {
			search_field.addEventListener('input', search.handleInput);
			search_field.addEventListener('blur', function(event) {
				search.hideResults();
			});
			search_field.addEventListener('focus', function(event) {
				search.restoreResults();
			});
		}
	},
	handleInput: function(event) {
		if (search.timeout > 0) {
			clearTimeout(search.timeout);
			search.timeout = 0;
		}
		
		search.timeout = setTimeout(search.performSearch, 250);
	},
	performSearch: function() {
		search.timeout = 0;
		
		var terms = document.getElementById('sidebar_search_field').value;
		var xhr = new XMLHttpRequest();
		xhr.open('GET', '/search/?query=' + encodeURIComponent(terms) + '&count=4', true);
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4 || xhr.status != 200) {
				return;
			}
			
			var obj = JSON.parse(xhr.responseText);
			search.displayResults(obj);
		};
		xhr.send();
	},
	displayResults: function(obj) {
		if (this.list === null) {
			this.list = document.createElement('div');
			this.list.id = 'floating_search_results';
			document.body.appendChild(this.list);
			
			this.list.addEventListener('mousedown', function(event) {
				event.stopPropagation();
				event.preventDefault();
			}, true);
		}
		
		// clear nodes
		while (this.list.firstChild) {
			this.list.removeChild(this.list.firstChild);
		}
		
		var results = obj.results;
		var total = obj.total;
		var terms = obj.terms;
		
		// add new nodes
		for (var i = 0; i < results.length; i++) {
			var link = document.createElement('a');
			link.href = results[i].url;
			link.appendChild(document.createTextNode(results[i].title));
			
			var tag = document.createElement('span');
			tag.className = 'result_type';
			tag.appendChild(document.createTextNode(results[i].type));
			
			var node = document.createElement('div');
			if ((i % 2) == 0) {
				node.className = 'result even';
			} else {
				node.className = 'result odd';
			}
			node.appendChild(link);
			node.appendChild(document.createTextNode(' '));
			node.appendChild(tag);
			
			this.list.appendChild(node);
		}
		
		if (total > results.length) {
			var link = document.createElement('a');
			link.href = '/search/?query=' + encodeURIComponent(terms);
			link.appendChild(document.createTextNode('More Results…'));
			
			var node = document.createElement('div');
			node.className = 'more';
			node.appendChild(link);
			
			this.list.appendChild(node);
		}
		
		// show or hide
		if (results.length > 0) {
			var field_bounds = document.getElementById('sidebar_search_field').getBoundingClientRect();
			
			this.list.style.display = 'flex';
			if (window.getComputedStyle(this.list, null).display != 'flex') {
				this.list.style.display = '-webkit-flex';
			}
			this.list.style.left = (field_bounds.left + 0) + 'px';
			this.list.style.top = (field_bounds.top + field_bounds.height + 3) + 'px';
		} else {
			this.list.style.display = 'none';
		}
	},
	hideResults: function() {
		if (this.list === null) {
			return;
		}
		
		this.list.style.display = 'none';
	},
	restoreResults: function() {
		if (this.list === null) {
			return;
		}
		
		if (document.getElementById('sidebar_search_field').value.trim() == '') {
			return;
		}
		
		this.list.style.display = 'flex';
	}
};
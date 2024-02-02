"use strict";

import { BeaconWebRequest } from "./classes/BeaconWebRequest.js";

class ExplorePopover {
	static container = null;
	static popover = null;
	static field = null;
	static link = null;
	static searchMoreURL = '';

	static init() {
		this.container = document.getElementById('explore_container');
		this.popover = document.getElementById('explore_popover');
		this.field = document.getElementById('explore_search_field');
		this.link = document.getElementById('menu_explore_link');

		if (!(this.container && this.popover && this.field && this.link)) {
			return;
		}

		this.container.addEventListener('click', (ev) => {
			this.dismiss();
			ev.stopPropagation();
			ev.stopImmediatePropagation();
			return false;
		});

		this.popover.addEventListener('click', (ev) => {
			ev.stopPropagation();
			ev.stopImmediatePropagation();
			return false;
		});

		this.link.addEventListener('click', (ev) => {
			ev.stopPropagation();
			ev.preventDefault();
			ev.stopImmediatePropagation();
			this.toggle();
			return false;
		});

		this.field.addEventListener('input', (ev) => {
			if (ev.target.searchTimeout) {
				clearTimeout(ev.target.searchTimeout);
				ev.target.searchTimeout = null;
			}
			ev.target.searchTimeout = setTimeout(() => {
				this.search(this.field.value);
			}, 1000);
		});

		document.getElementById('explore_results_back').addEventListener('click', () => {
			this.search('');
		});

		document.getElementById('explore_results_more').addEventListener('click', () => {
			window.location = this.searchMoreURL;
		});

		window.addEventListener('blur', () => {
			this.dismiss();
		});
	}

	static toggle() {
		if (this.container.style.display === 'none' || this.container.style.display === '') {
			this.present();
		} else {
			this.dismiss();
		}
	}

	static dismiss() {
		if (this.container.style.display === 'none') {
			return;
		}

		this.container.style.display = 'none';
		this.link.className = '';
		this.field.value = '';
		this.displayResults();
	}

	static present() {
		if (this.container.style.display === 'block') {
			return;
		}

		var rect = this.link.getBoundingClientRect();
		this.popover.style.top = rect.bottom + 'px';
		this.popover.style.left = Math.max(rect.left + ((rect.width - 320) / 2), 20) + 'px';
		this.container.style.display = 'block';
		this.link.className = 'expanded';
	}

	static search(terms) {
		if (!terms) {
			terms = '';
		}
		if (this.field.value !== terms) {
			this.field.value = terms;
		}
		if (terms === '') {
			this.displayResults();
			return;
		}

		const params = new URLSearchParams();
		params.append('query', terms.trim());
		params.append('count', 4);

		BeaconWebRequest.get(`/search?${params.toString()}`, { Accept: 'application/json' }).then((response) => {
			try {
				this.displayResults(JSON.parse(response.body));
			} catch (e) {
				console.log(e);
				this.displayResults();
			}
		}).catch(() => {
			this.displayResults();
		});
	}

	static displayResults(data = null) {
		const resultsContainer = document.getElementById('explore_results');
		const menu = document.getElementById('explore_links');

		if (!(data && data.results)) {
			resultsContainer.style.display = 'none';
			menu.style.display = 'block';
			return;
		}

		const list = document.getElementById('explore_results_list');
		while (list.firstChild) {
			list.removeChild(list.firstChild);
		}

		const results = data.results;
		const total = data.total;
		const terms = data.terms;

		if (results.length > 0) {
			menu.style.display = 'block';
			document.getElementById('explore_results_empty').style.display = 'none';

			let i = 0;
			for (const result of results) {
				let resultType = result.type;
				if (result.game) {
					resultType = `${result.game.name} ${resultType}`;
				}
				if (result.mod && result.mod.name) {
					resultType = `${resultType} from ${result.mod.name}`;
				}

				const link = document.createElement('a');
				link.href = result.url;
				const tag = document.createElement('span');
				tag.className = 'result_type';
				tag.appendChild(document.createTextNode(resultType));
				link.appendChild(document.createTextNode(result.title));
				link.appendChild(document.createElement('br'));
				link.appendChild(tag);

				const node = document.createElement('li');
				if ((i % 2) === 0) {
					node.className = 'result even';
				} else {
					node.className = 'result odd';
				}
				i++;
				node.appendChild(link);
				list.appendChild(node);
			}
		} else {
			menu.style.display = 'none';
			document.getElementById('explore_results_empty').style.display = 'block';
		}

		if (total > results.length) {
			document.getElementById('explore_results_right_button').style.display = 'block';
			this.searchMoreURL = '/search/?query=' + encodeURIComponent(terms);
		} else {
			document.getElementById('explore_results_right_button').style.display = 'none';
		}

		resultsContainer.style.display = 'block';
		menu.style.display = 'none';
	}
}

document.addEventListener('DOMContentLoaded', () => {
	ExplorePopover.init();
});

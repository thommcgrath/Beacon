"use strict";

if (!String.prototype.endsWith) {
	String.prototype.endsWith = function(search, this_len) {
		if (this_len === undefined || this_len > this.length) {
			this_len = this.length;
		}
		return this.substring(this_len - search.length, this_len) === search;
	};
}

if (!('randomUUID' in crypto)) {
	// https://stackoverflow.com/a/2117523/2800218
	// LICENSE: https://creativecommons.org/licenses/by-sa/4.0/legalcode
	crypto.randomUUID = function randomUUID() {
		return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16));
	};
}

class BeaconWebRequest {
	static prepareResponse(xhr) {
		return {
			xhr: xhr,
			status: xhr.status,
			statusText: xhr.statusText,
			body: xhr.responseText,
			success: (xhr.status >= 200 && xhr.status < 300)
		};
	}
	
	static start(method, url, body = null, headers = {}) {
		return new Promise((resolve, reject) => {
			const xhr = new XMLHttpRequest();
			xhr.open(method, url, true);
			if (typeof headers === 'object' && headers !== null && Array.isArray(headers) === false) {
				const keys = Object.keys(headers);
				for (const key of keys) {
					xhr.setRequestHeader(key, headers[key]);
				}
			}
			xhr.onload = () => {
				const response = this.prepareResponse(xhr);
				if (response.success) {
					resolve(response);
				} else {
					reject(response);
				}
			};
			xhr.onerror = () => {
				reject(this.prepareResponse(xhr));
			};
			xhr.send(body);
		});
	}
	
	static get(url, headers = {}) {
		return BeaconWebRequest.start('GET', url, null, headers);
	}
	
	static post(url, body, headers = {}) {
		if (body instanceof URLSearchParams) {
			headers['Content-Type'] = 'application/x-www-form-urlencoded';
			return BeaconWebRequest.start('POST', url, body.toString(), headers);
		} else if ((typeof body === 'object' && body !== null) || Array.isArray(body)) {
			headers['Content-Type'] = 'application/json';
			return BeaconWebRequest.start('POST', url, JSON.stringify(body), headers);
		} else {
			return BeaconWebRequest.start('POST', url, body, headers);
		}
	}
	
	static delete(url, headers = {}) {
		return BeaconWebRequest.start('DELETE', url, null, headers);
	}
}

class BeaconDialog {
	static activeModal = null;
	static viewportWatcher = null;
	
	static show(message, explanation = undefined, actionCaption = 'Ok') {
		return this.confirm(message, explanation, actionCaption, null);
	}
	
	static confirm(message, explanation = undefined, actionCaption = 'Ok', cancelCaption = 'Cancel') {
		return new Promise((resolve, reject) => {
			const overlay = document.getElementById('overlay');
			const dialogFrame = document.getElementById('dialog');
			const dialogMessage = document.getElementById('dialog_message');
			const dialogExplanation = document.getElementById('dialog_explanation');
			const dialogActionButton = document.getElementById('dialog_action_button');
			const dialogCancelButton = document.getElementById('dialog_cancel_button');
			
			if (!(overlay && dialogFrame && dialogMessage && dialogExplanation && dialogActionButton && dialogCancelButton)) {
				reject();
				return;
			}
			
			overlay.className = 'exist';
			dialogFrame.className = 'exist';
			setTimeout(() => {
				overlay.className = 'exist visible';
				dialogFrame.className = 'exist visible';
			}, 10);
			dialogMessage.innerText = message;
			if (explanation) {
				dialogExplanation.innerText = explanation;
			} else {
				dialogExplanation.innerText = '';	
			}
			
			if (dialogActionButton.clickHandler) {
				dialogActionButton.removeEventListener('click', dialogActionButton.clickHandler);
			}
			if (dialogCancelButton.clickHandler) {
				dialogCancelButton.removeEventListener('click', dialogCancelButton.clickHandler);
			}
			
			dialogActionButton.clickHandler = (event) => {
				this.hide();
				setTimeout(() => {
					resolve();
				}, 300);
			};
			dialogActionButton.addEventListener('click', dialogActionButton.clickHandler);
			dialogActionButton.innerText = actionCaption;
			
			if (cancelCaption) {
				dialogCancelButton.clickHandler = (event) => {
					this.hide();
					setTimeout(() => {
						reject();
					}, 300);
				};
				dialogCancelButton.addEventListener('click', dialogCancelButton.clickHandler);
				dialogCancelButton.innerText = cancelCaption;
			} else {
				dialogCancelButton.className = 'hidden';
			}
		});
	}
	
	static hide() {
		var overlay = document.getElementById('overlay');
		var dialogFrame = document.getElementById('dialog');
		if (!(overlay && dialogFrame)) {
			return;
		}
		overlay.className = 'exist';
		dialogFrame.className = 'exist';
		setTimeout(() => {
			overlay.className = '';
			dialogFrame.className = '';
		}, 300);
	}
	
	static showModal(elementId) {
		if (this.activeModal) {
			return;
		}
		
		const overlay = document.getElementById('overlay');
		const modal = document.getElementById(elementId);
		if (!(overlay && modal)) {
			return;
		}
		
		overlay.classList.add('exist');
		modal.classList.add('exist');
		this.activeModal = elementId;
		
		setTimeout(() => {
			overlay.classList.add('visible');
			modal.classList.add('visible');
		}, 10);
		
		this.viewportWatcher = setInterval(() => {
			if (!this.activeModal) {
				return;
			}
			
			const contentAreas = document.querySelectorAll(`#${this.activeModal} .modal-content .content`);
			contentAreas.forEach((contentArea) => {
				modal.classList.toggle('scrolled', contentArea.scrollHeight > contentArea.clientHeight);
			});
			
			const viewportHeight = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0);
			modal.classList.toggle('centered', modal.clientHeight > viewportHeight * 0.75);
		}, 100);
	}
	
	static hideModal() {
		if (!this.activeModal) {
			return;
		}
		
		const overlay = document.getElementById('overlay');
		const modal = document.getElementById(this.activeModal);
		if (!(overlay && modal)) {
			return;
		}
		
		if (this.viewportWatcher) {
			clearInterval(this.viewportWatcher);
			this.viewportWatcher = null;
		}
		
		overlay.classList.remove('visible');
		modal.classList.remove('visible');
		
		setTimeout(() => {
			overlay.classList.remove('exist');
			modal.classList.remove('exist');
			this.activeModal = null;
		}, 300);
	}
}

class PagePanel {
	static pagePanels = {};
	
	element = null;
	pageMap = {};
	currentPageName = null;
	
	constructor(element) {
		this.element = element;
		
		const pages = element.querySelectorAll('div.page-panel-page');
		for (const page of pages) {
			const pageName = page.getAttribute('page');
			this.pageMap[pageName] = page;
			if (page.classList.contains('page-panel-visible')) {
				this.currentPageName = pageName;
			}
		}
		
		const links = element.querySelectorAll('div.page-panel-nav a');
		for (const link of links) {
			const pageName = link.getAttribute('page');
			this.pageMap[pageName].link = link;
			
			link.addEventListener('click', (ev) => {
				ev.preventDefault();
				this.switchPage(ev.target.getAttribute('page'));
			});
		}
		
		const ev = new Event('panelCreated');
		ev.panel = this;
		this.element.dispatchEvent(ev);
	}
	
	switchPage(newPageName) {
		const oldPageName = this.currentPageName;
		if (oldPageName === newPageName) {
			return;
		}
		if (!this.pageMap[newPageName]) {
			return;
		}
		
		this.pageMap[oldPageName].classList.remove('page-panel-visible');
		this.pageMap[oldPageName].link.parentElement.classList.remove('page-panel-active');
		this.pageMap[newPageName].classList.add('page-panel-visible');
		this.pageMap[newPageName].link.parentElement.classList.add('page-panel-active');
		this.currentPageName = newPageName;
		
		const ev = new Event('panelSwitched');
		ev.panel = this;
		this.element.dispatchEvent(ev);
	}
	
	static init() {
		const panels = document.querySelectorAll('div.page-panel');
		for (const panel of panels) {
			PagePanel.pagePanels[panel.id] = new PagePanel(panel);
		}
	}
}

document.addEventListener('DOMContentLoaded', () => {
	PagePanel.init();
});

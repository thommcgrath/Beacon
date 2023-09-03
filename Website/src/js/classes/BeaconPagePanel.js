export class BeaconPagePanel {
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
			if (this.pageMap[pageName]) {
				this.pageMap[pageName].link = link;
				
				link.addEventListener('click', (ev) => {
					ev.preventDefault();
					this.switchPage(ev.target.getAttribute('page'));
				});
			}
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
			BeaconPagePanel.pagePanels[panel.id] = new BeaconPagePanel(panel);
		}
	}
}

class SentinelLayout {
	static menuButton = null;
	static sidebar = null;
	
	static init() {
		this.menuButton = document.getElementById('menu-button');
		this.sidebar = document.getElementById('main-sidebar');
		
		this.menuButton.addEventListener('click', (ev) => {
			this.toggleMenu()
			ev.preventDefault();
			return false;
		});
	}
	
	static menuVisible() {
		return this.sidebar.classList.contains('visible');
	}
	
	static closeMenu() {
		if (this.menuVisible()) {
			this.sidebar.classList.remove('visible');
			this.menuButton.classList.remove('visible');
		}
	}
	
	static showMenu() {
		if (this.menuVisible() === false) {
			this.sidebar.classList.add('visible');
			this.menuButton.classList.add('visible');
		}
	}
	
	static toggleMenu() {
		if (this.menuVisible()) {
			this.closeMenu();
		} else {
			this.showMenu();
		}	
	}
}

document.addEventListener('DOMContentLoaded', () => {
	SentinelLayout.init();
});
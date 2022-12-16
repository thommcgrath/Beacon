class SentinelLayout {
	static sidebarButton = null;
	static sidebar = null;
	static userMenuButton = null;
	static userMenu = null;
	static blurOverlay = null;
	
	static init() {
		this.sidebarButton = document.getElementById('menu-button');
		this.sidebar = document.getElementById('main-sidebar');
		this.userMenuButton = document.getElementById('header-user-button');
		this.userMenu = document.getElementById('user-menu');
		this.blurOverlay = document.getElementById('blur');
		
		if (this.sidebar && this.sidebarButton) {
			this.sidebarButton.addEventListener('click', (ev) => {
				this.toggleSidebar()
				ev.preventDefault();
				return false;
			});
		}
		
		if (this.userMenu && this.userMenuButton) {
			const showMenu = (ev) => {
				this.showUserMenu(ev.type === 'touchstart');
				ev.preventDefault();
				return false;
			};
			
			this.userMenuButton.addEventListener('mouseenter', showMenu);
			this.userMenuButton.addEventListener('touchstart', showMenu);
			
			this.userMenu.addEventListener('mouseleave', (ev) => {
				this.closeUserMenu();
				ev.preventDefault();
				return false;
			});
			
			this.blurOverlay.addEventListener('touchstart', (ev) => {
				this.closeUserMenu();
				ev.preventDefault();
				return false;
			});
		}
		
		const copyUserIdLink = document.getElementById('user-menu-copy-id');
		copyUserIdLink.addEventListener('click', (ev) => {
			const userId = copyUserIdLink.getAttribute('userid');
			navigator.clipboard.writeText(userId);
			copyUserIdLink.innerText = 'Copied!';
			setTimeout(() => {
				copyUserIdLink.innerText = 'Copy User ID';
			}, 3000);
			ev.preventDefault();
			return false;
		});
	}
	
	static sidebarVisible() {
		return this.sidebar.classList.contains('visible');
	}
	
	static closeSidebar() {
		if (this.sidebarVisible()) {
			this.sidebar.classList.remove('visible');
			this.sidebarButton.classList.remove('visible');
		}
	}
	
	static showSidebar() {
		this.closeUserMenu();
		if (this.sidebarVisible() === false) {
			this.sidebar.classList.add('visible');
			this.sidebarButton.classList.add('visible');
		}
	}
	
	static toggleSidebar() {
		if (this.sidebarVisible()) {
			this.closeSidebar();
		} else {
			this.showSidebar();
		}	
	}
	
	static userMenuVisible() {
		return this.userMenu.classList.contains('visible') || this.userMenu.classList.contains('exists');
	}
	
	static closeUserMenu() {
		if (this.userMenuVisible()) {
			this.userMenu.classList.remove('visible');
			this.blurOverlay.classList.remove('visible');
			setTimeout(() => {
				this.userMenu.classList.remove('exists');
				this.blurOverlay.classList.remove('exists');
			}, 150);
		}
	}
	
	static showUserMenu(withOverlay) {
		this.closeSidebar();
		if (this.userMenuVisible() === false) {
			this.userMenu.classList.add('exists');
			if (withOverlay) {
				this.blurOverlay.classList.add('exists');
			}
			setTimeout(() => {
				this.userMenu.classList.add('visible');
				if (withOverlay) {
					this.blurOverlay.classList.add('visible');
				}
			}, 1);
		}
	}
	
	static toggleUserMenu() {
		if (this.userMenuVisible()) {
			this.closeUserMenu();
		} else {
			this.showUserMenu();
		}
	}
}

document.addEventListener('DOMContentLoaded', () => {
	SentinelLayout.init();
});
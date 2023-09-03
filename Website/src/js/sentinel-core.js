class SentinelCommon {
	static #authToken = null;
	static #apiDomain = null;
	static #nitradoAccessToken = null;
	
	static async init(authToken, apiDomain) {
		this.#authToken = authToken;
		this.#apiDomain = apiDomain;
		
		SentinelLayout.init();
		
		try {
			let accessToken = localStorage.getItem('nitradoAccessToken') || null;
			let validUntil = localStorage.getItem('nitradoAccessTokenExpiration') || null;
			const now = Math.floor(Date.now() / 1000);
			
			if (Boolean(accessToken) === false || Boolean(validUntil) === false || (validUntil - 86400) <= now) {
				const nitradoTokenResponse = await SentinelAPIRequest.start('GET', 'sentinel/oauth/Nitrado');
				const nitradoToken = nitradoTokenResponse.jsonObject;
				accessToken = nitradoToken.access_token;
				validUntil = nitradoToken.valid_until;
				localStorage.setItem('nitradoAccessToken', accessToken);
				localStorage.setItem('nitradoAccessTokenExpiration', validUntil);
			}
			this.#nitradoAccessToken = accessToken;
		} catch (e) {
		}
	}
	
	static get authToken() {
		return this.#authToken;
	}
	
	static get apiDomain() {
		return this.#apiDomain;
	}
	
	static get nitradoAccessToken() {
		return this.#nitradoAccessToken;
	}
}

class SentinelWebRequest {
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
}

class NitradoAPIRequest extends SentinelWebRequest {
	static start(method, url, body = null, headers = {}) {
		headers.Accept = 'application/json';
		headers.Authorization = `Bearer ${SentinelCommon.nitradoAccessToken}`;
		return super.start(method, `https://api.nitrado.net/${url}`, body, headers);
	}
}

class SentinelAPIRequest extends SentinelWebRequest {
	static prepareResponse(xhr) {
		const response = super.prepareResponse(xhr);
		response.message = '';
		response.jonObject = null;
		
		try {
			response.jsonObject = JSON.parse(response.body);
			if (response.jsonObject.message) {
				response.message = response.jsonObject.message;
			}
		} catch (e) {
		}
		
		return response;
	}
	
	static start(method, url, body = null, headers = {}) {
		if (url.startsWith('https://') === false) {
			if (url.startsWith('/') === false) {
				url = `/v3/${url}`;
			}
			url = `https://${SentinelCommon.apiDomain}${url}`;
		}
		
		headers.Accept = 'application/json';
		headers.Authorization = `Session ${SentinelCommon.authToken}`;
		return super.start(method, url, body, headers);
	}
}

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

class SentinelService {
	#serviceInfo = null;
	
	static async getUserServices() {
		try {
			const response = await SentinelAPIRequest.start('GET', 'sentinel/service');
			const servicesList = response.jsonObject;
			const services = [];
			for (const serviceInfo of servicesList) {
				services.push(new SentinelService(serviceInfo));
			}
			return services;
		} catch (e) {
			console.log(e.message);
		}
	}
	
	constructor(serviceInfo) {
		this.#serviceInfo = serviceInfo;
	}
	
	get serviceId() {
		return this.#serviceInfo.service_id;
	}
}

window.browserSupported = true;
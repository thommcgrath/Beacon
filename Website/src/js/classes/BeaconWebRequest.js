export class BeaconWebRequest {
	static prepareResponse(xhr) {
		return {
			xhr: xhr,
			status: xhr.status,
			statusText: xhr.statusText,
			body: xhr.responseText,
			success: (xhr.status >= 200 && xhr.status < 300) || xhr.status === 304,
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

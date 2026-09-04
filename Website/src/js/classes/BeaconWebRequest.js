export class BeaconWebRequest {
	static prepareResponse(xhr) {
		const obj = {
			xhr: xhr,
			status: xhr.status,
			statusText: xhr.statusText,
			body: xhr.responseText,
			success: (xhr.status >= 200 && xhr.status < 300) || xhr.status === 304,
		};

		if (!obj.success) {
			try {
				const parsed = JSON.parse(obj.body);
				if (parsed.message) {
					obj.message = parsed.message;
				}
			} catch {
			}
			if (!obj.message) {
				switch (obj.status) {
				case 400:
					obj.message = 'Bad request';
					break;
				case 401:
					obj.message = 'Unauthorized';
					break;
				case 403:
					obj.message = 'Forbidden';
					break;
				case 404:
					obj.message = 'File not found';
					break;
				case 429:
					obj.message = 'Rate limit exceeded';
					break;
				case 500:
					obj.message = 'Internal server error';
					break;
				case 503:
					obj.message = 'Service unavailable';
					break;
				case 504:
					obj.message = 'Gateway timeout';
					break;
				default:
					obj.message = `HTTP ${obj.status} ${obj.statusText} error`;
					break;
				}
			}
		}

		return obj;
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

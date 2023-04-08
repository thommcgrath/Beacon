"use strict";

class BeaconCurrency {
	static #globalize = null;
	static #formatters = {};
	static #currencyCode = null;
	static #defaultFormatter = null;
	
	static get currencyCode() {
		return this.#currencyCode;
	}
	
	static set currencyCode(newCurrencyCode) {
		this.#currencyCode = newCurrencyCode;
		this.#defaultFormatter = this.getFormatter(newCurrencyCode);
	}
	
	static getFormatter(currencyCode) {
		if (!this.#formatters[currencyCode] && this.#globalize) {
			this.#formatters[currencyCode] = this.#globalize.currencyFormatter(currencyCode);
		}
		return this.#formatters[currencyCode];
	}
	
	static get defaultFormatter() {
		return this.#defaultFormatter;
	}
	
	static load() {
		const dataFiles = [
			'supplemental/likelySubtags.json',
			'main/en/numbers.json',
			'supplemental/numberingSystems.json',
			'supplemental/plurals.json',
			'supplemental/ordinals.json',
			'main/en/currencies.json',
			'supplemental/currencyData.json'
		];
		const dataPromises = [];
		for (const dataFile of dataFiles) {
			dataPromises.push(BeaconWebRequest.get(`/assets/scripts/thirdparty/cldr/${dataFile}`).then((response) => {
				try {
					Globalize.load(JSON.parse(response.body));
				} catch (loadErr) {
					console.log(loadErr);
				}
			}).catch((err) => {
				console.log(`Error: ${err.statusText}`);
			}));
		}
		Promise.all(dataPromises).then(() => {
			this.#globalize = Globalize('en');
			if (this.#currencyCode && !this.#defaultFormatter) {
				this.#defaultFormatter = this.getFormatter(this.#currencyCode);
			}
			
			const prices = document.querySelectorAll('.formatted-price');
			prices.forEach((elem) => {
				const price = parseFloat(elem.getAttribute('beacon-price') ?? elem.innerText);
				const currency = elem.getAttribute('beacon-currency');
				if (currency) {
					elem.innerText = BeaconCurrency.getFormatter(currency)(price);
				} else {
					elem.innerText = BeaconCurrency.defaultFormatter(price);
				}
			});
			
			document.dispatchEvent(new Event('GlobalizeLoaded'));
		});
	}
}

document.addEventListener('DOMContentLoaded', () => {
	BeaconCurrency.load();
});

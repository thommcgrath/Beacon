"use strict";

export const getCurrencyFormatter = (currencyCode) => {
	return Intl.NumberFormat('en-US', {
		style: 'currency',
		currency: currencyCode,
	}).format;
};

export const formatPrices = (defaultCurrency) => {
	const prices = document.querySelectorAll('.formatted-price');
	prices.forEach((elem) => {
		const price = parseFloat(elem.getAttribute('beacon-price') ?? elem.innerText);
		const currency = elem.getAttribute('beacon-currency');
		const formatter = getCurrencyFormatter(currency ?? defaultCurrency);
		if (formatter) {
			elem.innerText = formatter(price);
		}
	});
};

export const epochToDate = (epoch) => {
	return new Date(epoch * 1000);
};

export const formatDate = (date, withTime) => {
	const options = {
		dateStyle: 'medium',
	};
	if (withTime) {
		options.timeStyle = 'short';
	}
	return Intl.DateTimeFormat(Intl.DateTimeFormat().resolvedOptions().locale, options).format(date);
};

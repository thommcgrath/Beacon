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

export const formatDate = (date, withTime = false, withTimeZone = false) => {
	const resolvedOptions = Intl.DateTimeFormat().resolvedOptions();
	const options = {
		dateStyle: 'medium',
	};
	if (withTime) {
		options.timeStyle = 'short';
	}
	let formatted = Intl.DateTimeFormat(resolvedOptions.locale, options).format(date);
	if (withTimeZone) {
		formatted = `${formatted} ${resolvedOptions.timeZone}`;
	}
	return formatted;
};

export const formatDates = (withTime = false, withTimeZone = false) => {
	const timeElements = document.querySelectorAll('time');
	timeElements.forEach((elem) => {
		const timestamp = new Date(elem.getAttribute('datetime'));
		elem.innerText = formatDate(timestamp, withTime, withTimeZone);
	});
};

export const randomUUID = () => {
	if (crypto.randomUUID) {
		return crypto.randomUUID();
	} else {
		return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16));
	}
};

export const readFile = (file) => {
	return new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = () => {
			resolve(reader.result);
		};
		reader.onerror = reject;
		reader.readAsBinaryString(file);
	});
};

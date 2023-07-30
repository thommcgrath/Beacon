import { formatDate } from "./common.js";

document.addEventListener('DOMContentLoaded', () => {
	const timeElements = document.getElementsByTagName('time');
	for (const timeElement of timeElements) {
		const lastUpdate = new Date(timeElement.getAttribute('datetime'));
		timeElement.innerText = `${formatDate(lastUpdate, true)} ${Intl.DateTimeFormat().resolvedOptions().timeZone}`;
	}
});

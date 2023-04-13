"use strict";

const updateScreenNotice = () => {
	const screen = window.screen;
	const screenWidthPoints = screen.width;
	const screenHeightPoints = screen.height;
	const screenWidthPixels = screenWidthPoints * window.devicePixelRatio;
	const screenHeightPixels = screenHeightPoints * window.devicePixelRatio;
	
	const isMac = navigator.platform.indexOf('Mac') > -1;
	const isWindows = navigator.platform.indexOf('Win') > -1;
	
	let notice = null;
	if (screenWidthPoints < 1280 || screenHeightPoints < 720) {
		notice = 'This screen may not be supported. A resolution of at least 1280x720 points is required.';
		if (screenWidthPixels >= 1280 && screenHeightPixels >= 720) {
			const maxScalingSupported = Math.round(Math.min(screenWidthPixels / 1280, screenHeightPixels / 720) * 100);
			if (isWindows) {
				notice = 'Your display scaling settings may prevent Beacon from fitting on your screen. If you experience trouble fitting Beacon\'s window on your screen, try changing your display scaling to ' + maxScalingSupported + '% or lower. <a href="https://www.windowscentral.com/how-set-custom-display-scaling-setting-windows-10#change_display_scaling_default_settings_windows10">Learn how to change scaling settings.</a>';
			}
		}
	}
	
	if (notice) {
		const screenNotice = document.getElementById('screenCompatibilityNotice');
		if (screenNotice) {
			screenNotice.innerHTML = notice;
			screenNotice.classList.remove('hidden');
		}
	}
};

const buildDownloadsTable = async () => {
	const downloadMac = 'macOS';
	const downloadWinUniversal = 'windows-universal';
	const downloadWinIntel64 = 'windows-x64';
	const downloadWinIntel = 'windows-x86';
	const downloadWinARM64 = 'windows-arm64';
	
	let priorities = [downloadWinIntel64, downloadMac, downloadWinIntel, downloadWinARM64];
	let hasRecommendation = false;
	
	switch (navigator.platform) {
	case 'Win32':
		// Try to use client hints to determine the best version, but this isn't supported in Firefox
		if ('userAgentData' in navigator) {
			await navigator.userAgentData.getHighEntropyValues(['architecture', 'bitness']).then((ua) => {
				if (ua.bitness == 32) {
					priorities = [downloadWinIntel, downloadWinIntel64, downloadWinARM64, downloadMac];
					hasRecommendation = true;
				} else if (ua.bitness == 64) {
					if (ua.architecture == 'arm') {
						priorities = [downloadWinARM64, downloadWinIntel, downloadWinIntel64, downloadMac];
						hasRecommendation = true;
					} else if (ua.architecture == 'x86') {
						priorities = [downloadWinIntel64, downloadWinIntel, downloadWinARM64, downloadMac];
						hasRecommendation = true;
					}
				}
			}).catch(() => {});
		}
		if (hasRecommendation === false) {
			priorities = [downloadWinUniversal, downloadWinIntel64, downloadWinIntel, downloadWinARM64, downloadMac];
			hasRecommendation = true;	
		}
		break;
	case 'MacIntel':
		// Mac is simple, there's only one version
		priorities = [downloadMac, downloadWinIntel64, downloadWinIntel, downloadWinARM64];
		hasRecommendation = true;
		break;
	}
	
	const addChildRow = (table, label, url, buttonCaption = 'Download') => {
		let childRow = document.createElement('div');
		childRow.classList.add('row');
		let childLabel = document.createElement('div');
		childLabel.classList.add('label');
		childLabel.innerHTML = label;
		let childDownload = document.createElement('div');
		childDownload.classList.add('button');
		let childButton = document.createElement('a');
		childButton.classList.add('button');
		childButton.classList.add('default');
		childButton.href = url;
		childButton.innerText = buttonCaption;
		childButton.setAttribute('rel', 'nofollow');
		childDownload.appendChild(childButton);
		childRow.appendChild(childLabel);
		childRow.appendChild(childDownload);
		table.appendChild(childRow);
	};
	
	const addChildRows = (table, data, recommend) => {
		if (hasRecommendation === false) {
			let warningRow = document.createElement('div');
			warningRow.classList.add('row');
			let warningLabel = document.createElement('div');
			warningLabel.classList.add('full');
			warningLabel.classList.add('text-red');
			warningLabel.innerText = 'Sorry, this version of Beacon is not compatible with your device. But just in case a mistake was made, here are the download links.';
			warningRow.appendChild(warningLabel)
			table.appendChild(warningRow);
		}
		
		let first = true; // Set first only after a row is added, in case one gets skipped
		for (const downloadKey of priorities) {
			let recommendedTag = (recommend === true && hasRecommendation === true && first === true) ? '<span class="tag blue mini left-space">Recommended</span>' : '';
			
			switch (downloadKey) {
			case downloadMac:
				if (data.hasOwnProperty('mac_url')) {
					addChildRow(table, `Mac${recommendedTag}<br><span class="mini text-lighter">For macOS ${data.mac_display_versions}</span>`, data.mac_url);
					first = false;
				}
				break;
			case downloadWinIntel:
				if (data.hasOwnProperty('win_32_url')) {
					addChildRow(table, `Windows x86 32-bit${recommendedTag}<br><span class="mini text-lighter">For 32-bit versions of ${data.win_display_versions}</span>`, data.win_32_url);
					first = false;
				}
				break;
			case downloadWinIntel64:
				if (data.hasOwnProperty('win_64_url')) {
					addChildRow(table, `Windows x86 64-bit${recommendedTag}<br><span class="mini text-lighter">For 64-bit versions of ${data.win_display_versions}</span>`, data.win_64_url);
					first = false;
				}
				break;
			case downloadWinARM64:
				if (data.hasOwnProperty('win_arm64_url')) {
					addChildRow(table, `Windows ARM 64-bit${recommendedTag}<br><span class="mini text-lighter">For 64-bit versions of ${data.win_arm_display_versions}</span>`, data.win_arm64_url);
					first = false;
				}
				break;
			case downloadWinUniversal:
				if (data.hasOwnProperty('win_combo_url')) {
					addChildRow(table, `Windows Universal${recommendedTag}<br><span class="mini text-lighter">For all versions of ${data.win_display_versions}</span>`, data.win_combo_url);
					first = false;
				}
				break;
			}
		}
		
		addChildRow(table, 'Engrams Database, updated <time datetime="' + data.engrams_date + '">' + data.engrams_date_display + '</time>', data.engrams_url);
		addChildRow(table, 'Release Notes', data.history_url, 'View');
	};
	
	const stableTable = document.getElementById('stable-table');
	const prereleaseTable = document.getElementById('prerelease-table');
	const legacyTable = document.getElementById('legacy-table');
	
	const current = downloadData.current;
	if (current) {
		const headerRow = document.createElement('div');
		headerRow.classList.add('row');
		const headerBody = document.createElement('div');
		headerBody.classList.add('full');
		headerBody.innerText = 'Stable Version: Beacon ' + current.build_display;
		headerRow.appendChild(headerBody);
		stableTable.appendChild(headerRow);
		
		addChildRows(stableTable, current, true);
	}
	
	const prerelease = downloadData.preview;
	if (prerelease) {
		const headerRow = document.createElement('div');
		headerRow.classList.add('row');
		const headerBody = document.createElement('div');
		headerBody.classList.add('full');
		headerBody.innerText = 'Preview Version: Beacon ' + prerelease.build_display;
		headerRow.appendChild(headerBody);
		prereleaseTable.appendChild(headerRow);
		
		addChildRows(prereleaseTable, prerelease, false);
	} else {
		prereleaseTable.classList.add('hidden');
	}
	
	const legacy = downloadData.legacy;
	if (legacy) {
		const headerRow = document.createElement('div');
		headerRow.classList.add('row');
		const headerBody = document.createElement('div');
		headerBody.classList.add('full');
		headerBody.innerText = 'Legacy Version: Beacon ' + legacy.build_display;
		headerRow.appendChild(headerBody);
		legacyTable.appendChild(headerRow);
		
		addChildRows(legacyTable, legacy, false);
	} else {
		legacyTable.classList.add('hidden');
	}
	
	document.getElementById('mac_version_requirements').innerText = 'macOS ' + current.mac_display_versions;
	document.getElementById('win_version_requirements').innerText = current.win_display_versions;
};

document.addEventListener('DOMContentLoaded', () => {
	updateScreenNotice();
	buildDownloadsTable();
});

document.addEventListener('DOMContentLoaded', () => {
	const mainWrapper = document.getElementById('main_wrapper');
	const navigator = document.getElementById('navigator');
	const pages = mainWrapper.getElementsByClassName('page');
	const pips = navigator.getElementsByClassName('pip');
	let currentPageIndex = 0;
	const backButton = document.getElementById('previous_button');
	const nextButton = document.getElementById('next_button');
	const switchPages = (newIdx) => {
		if (currentPageIndex === newIdx || newIdx < 0 || newIdx >= pages.length) {
			return;
		}
		
		const currentPage = pages[currentPageIndex];
		const nextPage = pages[newIdx];
		if (newIdx > currentPageIndex) {
			currentPage.classList.add('left');
		} else {
			currentPage.classList.add('right');
		}
		nextPage.classList.add('noanimation');
		if (newIdx > currentPageIndex) {
			nextPage.classList.add('right');
			nextPage.classList.remove('left');
		} else {
			nextPage.classList.add('left');
			nextPage.classList.remove('right');
		}
		setTimeout(function() {
			nextPage.classList.remove('noanimation');
			nextPage.classList.remove('left');
			nextPage.classList.remove('right');
		}, 1);
		document.title = nextPage.getAttribute('beacon-title');
		
		const isFirstPage = (newIdx === 0);
		const isLastPage = (newIdx === pages.length - 1);
		backButton.disabled = isFirstPage;
		nextButton.innerText = (isLastPage ? 'Finished' : 'Next');
		
		for (let pipidx = 0; pipidx < pips.length; pipidx++) {
			pips[pipidx].className = (pipidx === newIdx) ? 'pip active' : 'pip';	
		}
		
		currentPageIndex = newIdx;
	};
	const nextPage = () => {
		if (currentPageIndex >= pages.length - 1) {
			window.location = 'beacon://finished';
		} else {
			switchPages(currentPageIndex + 1);
		}
	};
	const previousPage = () => {
		if (currentPageIndex === 0) {
			return;
		}
		
		switchPages(currentPageIndex - 1);
	};
	nextButton.addEventListener('click', (event) => {
		event.preventDefault();
		nextPage();
	});
	backButton.addEventListener('click', (event) => {
		event.preventDefault();
		previousPage();
	});
	
	for (let pageidx = 0; pageidx < pages.length; pageidx++) {
		const page = pages[pageidx];
		const pip = pips[pageidx];
		if (pageidx === 0) {
			document.title = page.getAttribute('beacon-title');
			if (pip !== null) {
				pip.className = 'pip active';
			}
		} else {
			page.classList.add('right');
		}
		
		if (pip !== null) {
			(function() {
				var pidx = pageidx;
				pip.addEventListener('click', function() {
					switchPages(pidx);
				});
			}());
		}
	}
	
	const hasMultiplePages = pages.length > 1;
	const skipButton = document.getElementById('skip_button');
	if (hasMultiplePages) {
		skipButton.addEventListener('click', (event) => {
			event.preventDefault();
			window.location = 'beacon://finished';
		});
	} else {
		skipButton.style.display = 'none';
		backButton.style.display = 'none';
	}
	
	if (pages.length === 1) {
		nextButton.innerText = 'Finished';
	}
	
	mainWrapper.classList.add('animated');
});

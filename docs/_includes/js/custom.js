window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
  if (event.matches) {
      jtd.setTheme('beacon-dark');
  } else {
      jtd.setTheme('beacon-light');
  }
});

if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    jtd.setTheme('beacon-dark');
}

document.addEventListener('DOMContentLoaded', function() {
	var screenshots = document.querySelectorAll('div.screenshot a img');
	for (idx = 0; idx < screenshots.length; idx++) {
		var screenshot = screenshots[idx];
		screenshot.addEventListener('load', function() {
			var link = this.parentElement;
			link.setAttribute('data-pswp-width', this.naturalWidth);
			link.setAttribute('data-pswp-height', this.naturalHeight);
		});
	}

	if (screenshots.length > 0) {
		var lightbox = new PhotoSwipeLightbox({
			gallery: '#main-content',
			children: 'div.screenshot a',
			pswpModule: PhotoSwipe,
		});
		lightbox.init();
	}
});

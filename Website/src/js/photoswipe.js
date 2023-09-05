import PhotoSwipeLightbox from "photoswipe/lightbox";
import PhotoSwipe from "photoswipe";

document.addEventListener('beaconRunPhotoswipe', ({ galleryIds }) => {
	for (const galleryId of galleryIds) {
		const lightbox = new PhotoSwipeLightbox({
			gallery: `#${galleryId}`,
			children: 'a',
			pswpModule: () => PhotoSwipe,
		});
		lightbox.init();
	}
});

document.addEventListener('DOMContentLoaded', () => {
	const services = SentinelService.getUserServices().then((services) => {
		for (const service of services) {
			console.log(service.serviceId);
		}
	});
	
	const addServersButton = document.getElementById('button-add-servers');
	addServersButton.addEventListener('click', async (ev) => {
		const token = SentinelCommon.nitradoAccessToken;
		if (!token) {
			// Start OAuth
			try {
				const obj = await SentinelAPIRequest.start('GET', '/oauth/index.php?provider=Nitrado&return_uri=' + encodeURIComponent(window.location.href));
				window.location.href = obj.location;
			} catch (e) {
				// Do something with the error
				return;
			}
		}
		
		addServersButton.innerText = 'Waiting…';
		try {
			const nitradoServices = await NitradoAPIRequest.start('GET', 'services');
			console.log(nitradoServices);
		} catch (e) {
			// Do another something
			return;
		}
		addServersButton.innerText = 'Add Servers';
		
		ev.preventDefault();
	});
});
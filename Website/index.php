<?php
unset($_SERVER['PREFERRED_DOMAIN']);
require_once($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');
?><!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
		<meta charset="UTF-8">
		<title>Beacon</title>
		<link rel="stylesheet" href="assets/beacon.css" type="text/css">
		<link rel="stylesheet" href="assets/normalize.css" type="text/css">
	</head>
	<body>
		<div id="header">
			<div class="body">
				<div id="header-links">
					<div class="header-links-cell">
						<img id="header-devlogo" src="assets/images/DeveloperLogo.png" srcset="assets/images/DeveloperLogo@3x.png 3x, assets/images/DeveloperLogo@2x.png 2x, assets/images/DeveloperLogo.png 1x" width="76" height="60">
					</div>
					<div class="header-links-spacer">
						&nbsp;
					</div>
					<div class="header-links-cell">
						<a href="#">Download</a>
					</div>
					<div class="header-links-cell">
						<a href="#">Release Notes</a>
					</div>
					<div class="header-links-cell">
						<a href="#">API Access</a>
					</div>
				</div>
			</div>
		</div>
		<div id="hero">
			<div class="body">
				<img src="assets/images/Hero.png" srcset="assets/images/Hero@3x.png 3x, assets/images/Hero@2x.png 2x, assets/images/Hero.png 1x" width="320" height="312">
			</div>
		</div>
		<div id="content">
			<div class="body">
			</div>
		</div>
	</body>
</html>
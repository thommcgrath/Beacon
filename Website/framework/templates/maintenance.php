<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Beacon will be right back</title>
		<style>
		
		body {
			background: url(https://assets.usebeacon.app/images/site/header-background-colors.svg) no-repeat center center fixed;
			text-align: center;
			color: #ffffff;
			font-family: sans-serif;
			padding: 0px;
			margin: 0px;
		}
		
		a {
			color: #ffffff;	
		}
		
		#maintenance_logo {
			width: 400px;
			max-width: 90%;
		}
		
		#flex_outer {
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
			height: 100vh;
			box-sizing: border-box;
		}
		
		#flex_outer div {
			flex: 1;
			width: 100%;
		}
		
		#flex_first {
			align-self: flex-start;
			flex-basis: 1;
		}
		
		#flex_inner {
			flex: none;
			align-self: center;
			flex-basis: 2;
		}
		
		#flex_last {
			align-self: flex-end;
			flex-basis: 1;
		}
		</style>
	</head>
	<body>
		<div id="flex_outer">
			<div id="flex_first">&nbsp;</div>
			<div id="flex_inner">
				<img src="https://assets.usebeacon.app/images/site/beacon-title-white.svg" alt="Beacon" id="maintenance_logo">
				<p><?php echo htmlentities($buffer); ?></p>
				<p>If this is an emergency, send an email to <a href="mailto:help@usebeacon.app">help@usebeacon.app</a></p>
			</div>
			<div id="flex_last">&nbsp;</div>
		</div>
	</body>
</html>

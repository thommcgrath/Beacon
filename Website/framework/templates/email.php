<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><?php echo htmlentities($subject); ?></title>
	</head>
	<body style="margin: 0px; font-family: Helvetica, sans-serif;">
		<style>
		body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;background-color: #f2f2f2;color: #303030;}
		.ExternalClass {width:100%;}
		</style>
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td>&nbsp;</td>
				<td width="600" colspan="2" style="padding: 30px; text-align: center;"><img src="<?php echo BeaconCommon::AbsoluteURL(BeaconCommon::AssetURI('emailheader2.png')); ?>" srcset="<?php echo BeaconCommon::AbsoluteURL(BeaconCommon::AssetURI('emailheader2.png')); ?> 1x, <?php echo BeaconCommon::AbsoluteURL(BeaconCommon::AssetURI('emailheader2@2x.png')); ?> 2x, <?php echo BeaconCommon::AbsoluteURL(BeaconCommon::AssetURI('emailheader2@3x.png')); ?> 3x" width="210" height="60" alt="Beacon for Ark: Survival Evolved."></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td width="600" style="padding: 30px; font-size: 16px; background-color: #ffffff; color: #000000" colspan="2"><?php echo $body_html; ?></td>
				<td>&nbsp;</td>
			</tr>
			<tr style="font-size: 14px;">
				<td>&nbsp;</td>
				<td width="300" style="padding: 30px 15px 30px 30px;" align="left">This email was sent to <?php echo htmlentities($recipient); ?> because it was requested from <a href="https://beaconapp.cc">https://beaconapp.cc</a>.</td>
				<td width="300" style="padding: 30px 30px 30px 15px;" align="right">The ZAZ Studios<br><span style="font-size: 12px">PO Box 2311<br>Columbia, CT 06237</span></td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</body>
</html>
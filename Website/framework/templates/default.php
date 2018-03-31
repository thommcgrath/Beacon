<?php

if (!BeaconTemplate::IsHTML()) {
	echo $buffer;
	exit;
}

?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><?php echo htmlentities(BeaconTemplate::Title()); ?></title>
		<link href="/assets/css/main.css" rel="stylesheet" media="all" type="text/css">
		<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicon/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicon/favicon-16x16.png">
		<link rel="manifest" href="/assets/favicon/manifest.json">
		<link rel="mask-icon" href="/assets/favicon/safari-pinned-tab.svg" color="#713a9a">
		<link rel="shortcut icon" href="/assets/favicon/favicon.ico">
		<link rel="alternate" type="application/json" title="Beacon Developer Blog" href="/blog/json.php">
		<link rel="alternate" type="application/rss+xml" title="Beacon Developer Blog" href="/blog/rss.php">
		<meta name="apple-mobile-web-app-title" content="Beacon">
		<meta name="application-name" content="Beacon">
		<meta name="msapplication-config" content="/assets/favicon/browserconfig.xml">
		<meta name="theme-color" content="#713a9a">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script src="/assets/scripts/main.js"></script>
		<?php
		$header_lines = BeaconTemplate::ExtraHeaderLines();
		for ($i = 0; $i < count($header_lines); $i++) {
			$line = $header_lines[$i];
			if ($i == 0) {
				echo "$line\n";
			} else {
				echo "\t\t$line\n";
			}
			unset($line);
		}
		unset($header_lines);
		?>
	</head>
	<body>
		<div id="site_wrapper">
			<div id="header">
				<div id="header_hamburger_container"><img id="header_hamburger" src="/assets/images/hamburger-white.svg"></div>
				<div id="header_logo_container"><img id="header_logo" src="/assets/images/beacon-white.svg" alt="Beacon - A loot editor for Ark: Survival Evolved"></div>
				<div id="header_spacer"></div>
			</div>
			<div id="darkener"></div>
			<div id="sidebar">
				<div id="sidebar_logo_container"><img id="sidebar_logo" src="/assets/images/beacon-white.svg" alt="Beacon - A loot editor for Ark: Survival Evolved"><img id="sidebar_title" src="/assets/images/beacon-title-white.svg"></div>
				<div id="sidebar_search"><form action="/search.php" method="get"><input type="search" placeholder="Search" id="sidebar_search_field" name="query" autocomplete="off"></form></div>
				<div id="sidebar_double_button"><a href="/download/">Download</a><a href="/donate.php">Donate</a></div>
				<div id="sidebar_menu">
					<h3>Help</h3>
					<ul>
						<?php
						
						$article_ids = array('96d0efc7-2e62-4ae4-9d9b-70cc890dc98e', '78cf1d4c-2368-4d24-ab73-00ba80a85fd7');
						foreach ($article_ids as $article_id) {
							$article = BeaconArticleMetadata::GetByArticleID($article_id);
							echo '<li><a href="/read.php/' . $article->ArticleID() . '">' . htmlentities($article->Title()) . '</a></li>';
						}
						
						?><li><a href="/spawn/">Ark Spawn Codes</a></li>
						<li><a href="/help/">More Topics&hellip;</a></li>
					</ul>
					<h3>News</h3>
					<ul>
						<?php
						
						$posts = BeaconArticleMetadata::GetRecentArticles(3, BeaconArticleMetadata::TYPE_BLOG);
						foreach ($posts as $post) {
							echo '<li><a href="/read.php/' . $post->ArticleID() . '">' . htmlentities($post->Title()) . '</a></li>';
						}
						
						?>
						<li><a href="/blog/">Older&hellip;</a></li>
					</ul>
					<h3>Community</h3>
					<ul>
						<li><a href="/browse/">Browse Community Configs</a></li>
						<li><a href="/mods/">Supported Mods</a></li>
					</ul>
				</div>
			</div>
			<div id="main">
				<?php echo $buffer; ?>
				<footer class="inner">
					<p><a id="footer_github_logo" href="https://github.com/thommcgrath/Beacon"><img height="24" src="/assets/images/github-color.svg"></a><a id="footer_patreon_logo" href="https://www.patreon.com/thommcgrath"><img height="24" src="/assets/images/patreon-color.svg"></a><a id="footer_discord_logo" href="https://discord.gg/2vbT7fV"><img height="24" src="/assets/images/discord-color.svg"></a></p>
					<p>Beacon is an open source project by Thom McGrath. Copyright 2016-<?php echo date('Y'); ?>.</p>
					<p>Get in touch using <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
				</footer>
			</div>
		</div>
	</body>
</html>
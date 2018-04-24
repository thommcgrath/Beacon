<?php

header('WWW-Authenticate: Session realm="Beacon User Dashboard"');
http_response_code(401);

?><h1>Authenticate</h1>
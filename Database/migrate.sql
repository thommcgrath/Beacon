-- dump data from old database
COPY (SELECT user_id, public_key FROM users) TO '/srv/beacon/users.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT document_id, user_id, last_update, revision, download_count, contents FROM documents) TO '/srv/beacon/documents.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT update_id, build_number, build_display, notes, mac_url, mac_signature, win_url, win_signature FROM updates) TO '/srv/beacon/updates.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT mod_id, workshop_id, user_id, name, confirmed, confirmation_code, pull_url, last_pull_hash FROM mods) TO '/srv/beacon/mods.csv' WITH (FORMAT csv, HEADER);
COPY (SELECT contents FROM presets) TO '/srv/beacon/presets.csv' WITH (FORMAT csv, HEADER);

-- import into new database, loot_sources and engrams must be prepared ahead of time, since there is no direct translation path
COPY users (user_id, public_key) FROM '/srv/beacon/users.csv' WITH (FORMAT csv, HEADER);
COPY documents (document_id, user_id, last_update, revision, download_count, contents) FROM '/srv/beacon/documents.csv' WITH (FORMAT csv, HEADER);
COPY updates (update_id, build_number, build_display, notes, mac_url, mac_signature, win_url, win_signature) FROM '/srv/beacon/updates.csv' WITH (FORMAT csv, HEADER);
COPY mods (mod_id, workshop_id, user_id, name, confirmed, confirmation_code, pull_url, last_pull_hash) FROM '/srv/beacon/mods.csv' WITH (FORMAT csv, HEADER);
COPY presets (contents) FROM '/srv/beacon/presets.csv' WITH (FORMAT csv, HEADER);
COPY loot_sources (object_id, label, min_version, last_update, mod_id, path, class_string, availability, kind, multiplier_min, multiplier_max, uicolor, icon) FROM '/srv/beacon/loot_sources.csv' WITH (FORMAT csv, HEADER);
COPY engrams (object_id, label, min_version, last_update, mod_id, path, class_string, availability, can_blueprint) FROM '/srv/beacon/engrams.csv' WITH (FORMAT csv, HEADER);
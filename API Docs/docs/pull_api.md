# Engrams Pull API

Rather than using Beacon's UI or API, there is a third way to maintain a list of engrams for a mod: pull.

This option allows developers to host a file on any server of their choosing and updated it whenever and however they choose. The Beacon server will pull the file daily and synchronize its engrams database using the content of the file. The engrams for the mod in question will be updated to exactly match the file's contents, meaning missing engrams will be removed.

## Getting Started

To begin, developers have two options:

1. Either set the `pull_url` key of the mod structure to the url.
2. Use Beacon's Developer Tools to set the url. Go to the [mods section](beacon://action/showmods) and select the mod. Use the settings icon at the bottom of the list and set the url there.

## File Format

Developers can choose to provide the data one of the following formats. The server must reply with a 200 status and provide the correct Content-Type header.

### JSON

Content-Type: application/json

This file content is identical to the [engram.php POST](engram.md#post) method content. The `mod_id` key is optional, but will be ignored if provided.

```json
[
  {
    "class": "Prefix_MyEngram_C",
    "label": "My Engram",
    "availability": [
      "Island",
      "Scorched"
    ],
    "can_blueprint": true,
    "harvestable": false
  }
]
```

### CSV

Content-Type: text/csv

The CSV file must contain a header row. The columns must match the [engram structure](engram.php#engram-structure). The `mod_id` key is optional, but will be ignored if provided. The `availability` column may be a comma-separated string.

```csv
"class","label","availability","can_blueprint","harvestable"
"Prefix_MyEngram_C","My Engram","Island,Scorched","true","false"
```

## Errors

If there are any errors, Beacon will send back a POST to the url with the form values `mod_id` and `message`. All processing will halt at the first error.
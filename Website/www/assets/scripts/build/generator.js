"use strict";

if (Number.parseInt === undefined) {
  Number.parseInt = window.parseInt;
}
var difficulty = {
  init: function () {
    var dino_level_field = document.getElementById('dino_level_field');
    if (dino_level_field) {
      dino_level_field.addEventListener('input', function (event) {
        difficulty.updateUI();
      });
    }
    this.updateUI();
  },
  updateUI: function () {
    var desired_dino_level = 120;
    var dino_level_field = document.getElementById('dino_level_field');
    if (dino_level_field) {
      desired_dino_level = Number.parseInt(dino_level_field.value);
    }
    var override = desired_dino_level / 30;
    var reference = document.getElementById('difficulty_reference');
    if (reference) {
      var lines = [];
      lines.push('DifficultyOffset=1.0');
      lines.push('OverrideOfficialDifficulty=' + override.toFixed(4));
      reference.value = lines.join("\n");
    }
    var value_create = document.getElementById('create_difficulty_value');
    if (value_create) {
      value_create.value = override.toFixed(1);
    }
    var value_paste = document.getElementById('paste_difficulty_value');
    if (value_paste) {
      value_paste.value = override.toFixed(1);
    }
    var value_upload = document.getElementById('upload_difficulty_value');
    if (value_upload) {
      value_upload.value = override.toFixed(1);
    }
  }
};
document.addEventListener('DOMContentLoaded', function () {
  difficulty.init();
  if (document.getElementById('mode_tabs') !== null) {
    document.getElementById('mode_tabs_new').addEventListener('click', function (event) {
      document.getElementById('mode_view_new').style.display = 'block';
      document.getElementById('mode_view_paste').style.display = 'none';
      document.getElementById('mode_view_upload').style.display = 'none';
      document.getElementById('mode_tabs_new').className = 'selected';
      document.getElementById('mode_tabs_paste').className = '';
      document.getElementById('mode_tabs_upload').className = '';
    });
    document.getElementById('mode_tabs_paste').addEventListener('click', function (event) {
      document.getElementById('mode_view_new').style.display = 'none';
      document.getElementById('mode_view_paste').style.display = 'block';
      document.getElementById('mode_view_upload').style.display = 'none';
      document.getElementById('mode_tabs_new').className = '';
      document.getElementById('mode_tabs_paste').className = 'selected';
      document.getElementById('mode_tabs_upload').className = '';
    });
    document.getElementById('mode_tabs_upload').addEventListener('click', function (event) {
      document.getElementById('mode_view_new').style.display = 'none';
      document.getElementById('mode_view_paste').style.display = 'none';
      document.getElementById('mode_view_upload').style.display = 'block';
      document.getElementById('mode_tabs_new').className = '';
      document.getElementById('mode_tabs_paste').className = '';
      document.getElementById('mode_tabs_upload').className = 'selected';
    });
  }
  var button = document.getElementById('copy_button');
  if (button !== null) {
    button.addEventListener('click', function (event) {
      var cell = document.getElementById('content_output');
      if (cell) {
        try {
          clipboard.writeText(cell.value);
          event.target.innerText = 'Copied!';
          event.target.disabled = true;
          setTimeout(function () {
            event.target.innerText = 'Copy';
            event.target.disabled = false;
          }, 3000);
        } catch (err) {
          alert('Looks like this browser does not support automatic copy. You will need to do it yourself.');
        }
      }
    });
  }
  var choose_field = document.getElementById('upload_file_selector');
  var choose_button = document.getElementById('upload_file_selector_button');
  if (choose_field && choose_button) {
    choose_button.addEventListener('click', function (event) {
      choose_field.click();
      if (event.preventDefault) {
        event.preventDefault();
      }
      return false;
    });
    choose_field.addEventListener('change', function (event) {
      if (this.value !== '') {
        this.form.submit();
      }
    });
  }
});
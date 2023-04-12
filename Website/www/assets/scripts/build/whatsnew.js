"use strict";

document.addEventListener('DOMContentLoaded', function () {
  var main_wrapper = document.getElementById('main_wrapper');
  var navigator = document.getElementById('navigator');
  var pages = main_wrapper.getElementsByClassName('page');
  var pips = navigator.getElementsByClassName('pip');
  var current_page_index = 0;
  var back_button = document.getElementById('previous_button');
  var next_button = document.getElementById('next_button');
  var switch_pages = function (new_idx) {
    if (current_page_index === new_idx || new_idx < 0 || new_idx >= pages.length) {
      return;
    }
    var current_page = pages[current_page_index];
    var next_page = pages[new_idx];
    if (new_idx > current_page_index) {
      current_page.classList.add('left');
    } else {
      current_page.classList.add('right');
    }
    next_page.classList.add('noanimation');
    if (new_idx > current_page_index) {
      next_page.classList.add('right');
      next_page.classList.remove('left');
    } else {
      next_page.classList.add('left');
      next_page.classList.remove('right');
    }
    setTimeout(function () {
      next_page.classList.remove('noanimation');
      next_page.classList.remove('left');
      next_page.classList.remove('right');
    }, 1);
    document.title = next_page.getAttribute('beacon-title');
    var is_first_page = new_idx === 0;
    var is_last_page = new_idx === pages.length - 1;
    back_button.disabled = is_first_page;
    next_button.innerText = is_last_page ? 'Finished' : 'Next';
    for (var pipidx = 0; pipidx < pips.length; pipidx++) {
      pips[pipidx].className = pipidx === new_idx ? 'pip active' : 'pip';
    }
    current_page_index = new_idx;
  };
  var next_page = function () {
    if (current_page_index >= pages.length - 1) {
      window.location = 'beacon://finished';
    } else {
      switch_pages(current_page_index + 1);
    }
  };
  var previous_page = function () {
    if (current_page_index === 0) {
      return;
    }
    switch_pages(current_page_index - 1);
  };
  next_button.addEventListener('click', function (event) {
    event.preventDefault();
    next_page();
  });
  back_button.addEventListener('click', function (event) {
    event.preventDefault();
    previous_page();
  });
  for (var pageidx = 0; pageidx < pages.length; pageidx++) {
    var page = pages[pageidx];
    var pip = pips[pageidx];
    if (pageidx === 0) {
      document.title = page.getAttribute('beacon-title');
      if (pip != null) {
        pip.className = 'pip active';
      }
    } else {
      page.classList.add('right');
    }
    if (pip != null) {
      (function () {
        var pidx = pageidx;
        pip.addEventListener('click', function () {
          switch_pages(pidx);
        });
      })();
    }
  }
  var has_multiple_pages = pages.length > 1;
  var skip_button = document.getElementById('skip_button');
  if (has_multiple_pages) {
    skip_button.addEventListener('click', function (event) {
      event.preventDefault();
      window.location = 'beacon://finished';
    });
  } else {
    skip_button.style.display = 'none';
    back_button.style.display = 'none';
  }
  if (pages.length === 1) {
    next_button.innerText = 'Finished';
  }
  main_wrapper.classList.add('animated');
});
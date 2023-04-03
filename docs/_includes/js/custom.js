window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
  if (event.matches) {
      jtd.setTheme('beacon-dark');
  } else {
      jtd.setTheme('beacon-light');
  }
});

if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    jtd.setTheme('beacon-dark');
}
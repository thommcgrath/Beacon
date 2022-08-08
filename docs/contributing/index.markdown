---
title: Contributing
has_children: false
nav_order: 9
---
# {{page.title}}

Beacon is an open source project, so contributions are welcome. All contributions should be made using a pull request.

## Documentation

Beacon's documentation is hosted from [GitHub Pages](https://pages.github.com/). To test locally, you will need Jekyll. [GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll) has some steps for installing and running a local server to preview the documentation site in your own forked copy of Beacon's repository.

### File Structure and Organization

All help pages must be named `index.markdown` and reside in a folder with a clear, simple, and url-friendly name. For instance, this page is `contributing/index.markdown` instead of `contributing.markdown` so that the url will look like `/contributing/`. Assets such as screenshots should be included in the same folder as the `index.markdown` file.

### Screenshots

Screenshots do not need to be a certain platform or color theme, but **must** include both a 1x and 2x version so that users on high pixel density displays can see sharp pictures. It is not acceptable to take a screenshot at 2x and scale it down. Screenshots should be PNG format, and preferably downsampled using a service like [TinyPNG](https://tinypng.com/).

Including screenshots should be done with the following code snippet:

```
{% raw %}{% include image.html file="image.png" file2x="image@2x.png" caption="This is a caption that will show with the image." %}{% endraw %}
```

### Styling

#### User Interface Elements
Referencing specific on-screen elements should be done using the `{% raw %}{:.ui-keyword}{% endraw %}` suffix on bold (`**`) tags. For example, instructing the user to press the button to create a new loot drop should look something like "Press the {% raw %}\*\*New Drop\*\*{:.ui-keyword}{% endraw %} button."

#### Colors
To better support dark mode users, avoid adding additional colors to pages. If absolutely necessary, use the color classes from the [Just the Docs Documentation](https://just-the-docs.github.io/just-the-docs/docs/utilities/color/).

## Beacon Application

## Beacon Website


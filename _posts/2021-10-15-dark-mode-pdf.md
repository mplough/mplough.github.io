---
layout: post
title:  "Dark Mode PDF viewing"
---

Dark mode is great for using a laptop at night with minimal illumination from
the screen.  Support for dark mode is fortunately growing.  E-book readers,
text editors, terminal applications, and a growing contingent of web sites all
support dark themes.

Viewing PDFs with a dark background is a little more difficult.

* Apple's Preview doesn't support a dark background for viewing PDFs.
* Apple's Books application in Big Sur has a dark theme for e-books and can
  catalog PDFs, but opens PDFs in Preview.
* The developers of [Skim](https://skim-app.sourceforge.io/) sanctimoniously
  rejected a [feature request for a dark background
  mode](https://sourceforge.net/p/skim-app/feature-requests/1509/) back in 2018.
* Inverting colors in the macOS accessibility settings results in a mouse
  cursor with garish glowing blue edges.
* [PDF Expert](https://pdfexpert.com/) supposedly has a dedicated night mode,
  but the paid version is $50/year and using even the free version requires
  creating an account to use local desktop software.  It's as if [The Right to
  Read](https://www.gnu.org/philosophy/right-to-read.en.html) was taken as a
  design brief rather than as a warning.

There are two halfway decent solutions:

[Negative Reader](http://mackozer.pl/negative-reader/) is a minimum viable
solution to the problem but it feels clunky.  There is no way to view
document thumbnails or a table of contents.  It would be much nicer to use a
tool that at least had feature parity with Preview.

A [Hacker News comment](https://news.ycombinator.com/item?id=25180600) contains
the best solution I've seen, and it modifies the Firefox's PDF viewer's
behavior in one line of JavaScript.

I made the code into a bookmarklet.  Drag the link to your bookmarks bar, open
a PDF, and click your new bookmark to turn out the lights:

<!--
Bookmarklet style cribbed from Alisdair McDiarmid's article:
Kill sticky headers
https://alisdair.mcdiarmid.org/kill-sticky-headers/

I would put this in assets/main.scss or assets/css/style.scss
but the minima theme is a mess.  The documentation on how to customize the
minima theme doesn't match how the theme actually works.
-->
<style>
.bookmarklet a {
    background: #16e;
    border-radius: 3px;
    border-bottom: 1px solid #139;
    color: #fff;
    padding: 0.5em 1em;
    text-decoration: none;
    transition-property: background;
    transition-duration: 150ms;
}
</style>

<p class=bookmarklet style="text-align: center;">
<a href="javascript:(function(){viewer.style = 'filter: grayscale(1) invert(1) sepia(1) contrast(75%)';})()">Dark Mode PDF</a>
</p>

The irony is not lost on me that this site doesn't support dark mode.  Someday!

---
layout: post
title:  "Monaco bold/italic"
---

Twelve-point [Monaco](http://www.identifont.com/show?1O2) has been my
programming font of choice for years.

Today while editing Markdown text I noticed that my editor wasn't rendering
bold or italic markup at all.  There was no bug in
[plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown) as I had
originally feared; instead it was happening because Monaco only comes with a
regular variant.  There might be better programming fonts available (maybe [B612
Mono](https://app.programmingfonts.org/#b612-mono)) but I would prefer not to
go down that rabbit hole.

Fortunately, bold and italic variants of Monaco are available.

The [monaco-bold](https://github.com/vjpr/monaco-bold) project on GitHub
contains three different bold variants of Monaco (20%, 30%, and 40%) as well as
an italic variant.  However, the variants are made available as regular
variants of entirely different fonts rather than as bold and italic variants of
the same font.  That won't play well with the `guifont` setting in Vim.

The [monego](https://github.com/cseelus/monego) project on GitHub, which is
forked from the [monaco-bold](https://github.com/vjpr/monaco-bold) project,
solves those problems, making available a font called Monego that's just Monaco
with bold and italic variants.  ~~It's missing a bold italic variant but that's
something I could add myself and contribute back if it bothers me too much.~~
UPDATE: A bold italic version got added on [April 8,
2019](https://github.com/cseelus/monego/commit/0c384f828c41c84ad94ebe8aaefc333307988cbc).

I installed the Monego font, set my iTerm2 profiles to use it, and updated my
`.gvimrc`'s font settings to:

```
set antialias
set guifont=Monego:h12
```

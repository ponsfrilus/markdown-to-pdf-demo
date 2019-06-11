# About

I was looking for a way to easily review the font rendering of a Pandoc
converted Markdown files to PDF. I found [@danstoner's
pandoc_sample](https://github.com/danstoner/pandoc_samples) but I wanted to test
some metadata and Unicode characters.

I also wanted to test the common Markdown demo file (e.g. GitHub Flavored
Markdown) to see the way they render in PDF.

[`XeLaTeX`](https://en.wikipedia.org/wiki/XeTeX) is the only engine tested here.

# Usage

## TL;DR
```
$ make all
```
and go for a break...


## Choose your fonts

The [sample.md](./input/sample.md) file contains some basic markdown syntax
(e.g. Title 1 to Title 6) and some Unicode characters (output of the `tree`
command). Feel free to add anything in this file, but be sure to leave some
Unicode characters.

Use the command

```
  $ make sample
```

to generate a list of fonts present on your system, use them as Pandoc parameter
to convert to PDF the sample files and get a list of Unicode (un)capable fonts
(`fonts_unicode_capable.txt` & `fonts_unicode_uncapable.txt`). Note: because it
convert the sample file with each fonts present on your system, it may take a
long time to get these 2 lists (e.g. 200 fonts * 10 seconds = 33 minutes).

### Get on PDF with all fonts

If more convenient for you, you can run `make onepdfwithallfonts` to get a
single file with all generated pdf (require
[pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)). An exemple of
output is available **[here](./all_fonts.pdf)**.

The main idea here is to choose the `mainfont` and `monofont` for the further
tests. The fonts `DejaVu Sans` and `DejaVu Sans Mono` are a good example,
because they are Unicode capable and both part of the same family.

## Demo

The command `make demo` use the markdown files in the input folder with some
pre-selected font. It's a way to preview how some markdown features are
converted to PDF.

| mainfont         | monofont              |
| ---------------- | --------------------- |
| Arial            | Courier New           |
| DejaVu Sans      | DejaVu Sans Mono      |
| FreeSans         | FreeMono              |
| Liberation Sans  | Liberation Mono       |
| Noto Sans CJK JP | Noto Sans Mono CJK JP |
| Ubuntu           | Ubuntu Mono           |

# Commands

These are some command that you can use to convert markdown document to PDF.

Default:
```
$ pandoc input/sample.md --pdf-engine=xelatex -o output/sample.pdf
```

With TOC:
```
$ pandoc input/sample.md --toc --pdf-engine=xelatex -o output/sample.pdf
```

With TOC and class report:
```
$ pandoc input/sample.md --toc -V documentclass=report --pdf-engine=xelatex -o output/sample.pdf
```

With paper size, geometry and specific font:
```
$ pandoc input/sample.md \
    --pdf-engine=xelatex \
    -V mainfont="DejaVu Sans" \
    -V urlcolor=cyan \
    -V papersize:a4paper \
    -V monofont="DejaVu Sans Mono" \
    -V geometry:vmargin=2cm \
    -V geometry:hmargin=3cm -o output/sample.pdf
```

# Input Files

The [input](./input) folder contains Markdown file that you want to convert with
Pandoc.

  * [Markdown-Cheatsheet.md](./Markdown-Cheatsheet.md): Demo file from [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
  * [Markdown-Here-Cheatsheet.md](./Markdown-Here-Cheatsheet.md): Demo file from [Markdown Here Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet)
  * [daringfireball.md](./daringfireball.md): Demo file from https://daringfireball.net/projects/markdown/syntax (add .text to this URL to see the source)
  * [hackmdio.md](./markdown-it.md): Demo file from https://hackmd.io/features
  * [markdown-it.md](./markdown-it.md): Demo file from https://markdown-it.github.io/
  * [sample.md](./sample.md): For some tests, metadata

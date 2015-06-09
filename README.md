# yamlsh

`yamlsh` is a YAML editing tool.

Editing YAML, especially on large files, is a total nightmare. Most tooling
rely on IDE/text editors folding-like features, but it's still up to the
developers and translators to search and scroll up and down.

Also when it comes to translations, the common guideline is to have one file
per language. Synchronizing language files manually leads to many errors.

`yamlsh` brings:

  1. An easy command-line navigation a-la-shell (`cd`, `ls`, etc.)
  2. An extensible command infrastructure


# Pre-requisite

* Any Ruby &amp; 2.0 installation 


# Installation

    sudo gem install yamlsh


# Usage

    λ yamlsh foo.yml
    # yamlsh - Franck Verrot <franck@verrot.fr> - MIT License - 2015
    $(root)> ls
    => en
    $(root)> cd en
    $(en)> ls
    => key1
    key2
    $(en)> get key1
    => Hello
    $(en)> get key2
    => {"foo"=>"bar", "baz"=>"bat"}
    $(en)> set key1
    Hit ENTER to stop typing
    > Hello World!
    => Hello World!
    $(en)> get key1
    => Hello World!
    $(en)> save
    => ok
    $(en)> quit


    Quitting...

    λ


# License

MIT License, Franck Verrot, Copyright 2015

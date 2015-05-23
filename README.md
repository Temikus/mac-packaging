mac-packaging
========

A set of common functions used for enterprise Mac Packaging with Munki.

How to install
--------------

oh-my-zsh
---------
* Download the script or clone this repository in [oh-my-zsh](http://github.com/robbyrussell/oh-my-zsh) plugins directory:

        cd ~/.oh-my-zsh/custom/plugins
        git clone git://github.com/temikus/mac-packaging.git

* Activate the plugin in `~/.zshrc`:

        plugins=( [plugins...] mac-packaging [plugins...])

* Source `~/.zshrc`  to take changes into account:

        source ~/.zshrc

antigen
-------
Add `antigen bundle temikus/mac-packaging` to your .zshrc where you're adding your other plugins. Antigen will clone the plugin for you and add it to your antigen setup the next time you start a new shell.

Commands/Usage:
------

* mkdmg - Makes a Munki-compatible DMG file out of an .app or pkg file and creates a manifest.

        makedmg foo.[app|pkg]

* mkmanifest - Generates a Munki manifest for a DMG file.

        mkmanifest foo.dmg

* check_appleid - prints unique user id for AppStore applications. Used to identify what user downloaded the application from the AppStore.

        check_appleid foo.app

Notes/Tips:
-----------

Plugin assumes that Munki tools are available in PATH:

        export PATH=$PATH:/usr/local/munki

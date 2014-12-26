# Notes for the LCA2015 Radare2 Tutorial

## Prerequisites

Minimum required is a C compiler and libraries needed to build radare2, and xdot for viewing callgraphs.

If you are using a Debian-derived distro, for example:

    sudo apt-get install build-essential xdot eog ghex binwalk

It should be possible to build radare2 on Linux, FreeBSD/NetBSD etc, Max OS/X and Windows

Tutorial examples have only been tested on Debian

## Clone & build radare2

Note, changing to the *tutorial* branch is important, I have some bug fixes not merged upstream

    git clone http://github/com/pastcompute/radare2
    cd radare2
    git checkout tutorial_branch
    ./configure
    make -j
    sudo make symstall

Note, you can install as a normal user if you need to:

    ./configure --prefix=$HOME/path/to/wherever
    make -j
    sudo make symstall
    export PATH=$HOME/path/to/wherever:$PATH

## Clone this repository

    cd
    git clone http://github/com/pastcompute/lca2015-radare2-tutorial

## Build misc example programs

    cd lca2015-radare2-tutorial
    make -C helpers

## Set a rc file

Radare2 will by default print fortune cookies.
Please, turn this off, in case there is a possibility of NSFW output...

    echo 'e cfg.fortunes=false' > ~/.radare2rc



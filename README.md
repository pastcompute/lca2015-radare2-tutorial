# Notes for the LCA2015 Radare2 Tutorial

## Prerequisites

Minimum required is a C compiler and libraries needed to build radare2, and xdot for viewing callgraphs.

Various other tools may be helpful.

If you are using a Debian-derived distro, for example:

    sudo apt-get install build-essential xdot eog ghex binwalk vim gedit

It should be possible to build radare2 on Linux, FreeBSD/NetBSD etc, Max OS/X and Windows

Note, the tutorial examples have only been tested using Debian Wheezy.

## Clone & build radare2

Note, changing to the *lca2015_tutorial* branch is important, there may be some fixes not merged upstream

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

## Set an rc file

Radare2 will by default print fortune cookies.
Please, turn this off, in case there is a possibility of NSFW output...

    echo 'e cfg.fortunes=false' > ~/.radare2rc

# If you want to build some of the pre-built binaries already in the git repository

## Arduino Binary Example

This requires the Arduino IDE, I used 1.0.6. It can be downloaded from http://arduino.cc/en/Main/Software

## MIPS Binary Example

I built the MIPS binaries using an OpenWRT buildroot, from OpenWRT Barrier Breaker for ar71xx.
This can be downloaded from https://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic.
Specifically, the file is [OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2](https://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2)


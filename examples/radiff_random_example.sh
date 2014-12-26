#!/bin/bash
#
# Create two random binary files almost the same
#

if [ -z "$JUST_DIFF" ] ; then
dd if=/dev/urandom of=file1.bin bs=1024 count=1
cp file1.bin file2.bin
fi

$PREFIX radiff2 file1.bin file2.bin

[ -z "$JUST_DIFF" ] && echo Changing 4 bytes && r2 -qnwc 's 0x12; wx 0xdeadbeef' file2.bin
$PREFIX radiff2 file1.bin file2.bin

[ -z "$JUST_DIFF" ] && echo Changing 4 more bytes && r2 -qnwc 's 0x212; wx 0xde2dbeef' file2.bin
$PREFIX radiff2 file1.bin file2.bin

[ -z "$JUST_DIFF" ] && echo Changing 4 more bytes && r2 -qnwc 's 0x337; wx 0xdeadb3ef' file2.bin
$PREFIX radiff2 file1.bin file2.bin


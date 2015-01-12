#!/bin/bash
#
# Create two random binary files almost the same
#

mkdir -p temp

F1=temp/similiar1.bin
F2=temp/similiar2.bin

if [ -z "$JUST_DIFF" ] ; then
dd if=/dev/urandom of=$F1 bs=1024 count=1
cp $F1 $F2
fi

$PREFIX radiff2 $F1 $F2

[ -z "$JUST_DIFF" ] && echo Changing 4 bytes && r2 -qnwc 's 0x12; wx 0xdeadbeef' $F2
$PREFIX radiff2 $F1 $F2

[ -z "$JUST_DIFF" ] && echo Changing 4 more bytes && r2 -qnwc 's 0x212; wx 0xde2dbeef' $F2
$PREFIX radiff2 $F1 $F2

[ -z "$JUST_DIFF" ] && echo Changing 4 more bytes && r2 -qnwc 's 0x337; wx 0xdeadb3ef' $F2
$PREFIX radiff2 $F1 $F2


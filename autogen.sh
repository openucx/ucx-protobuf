#!/bin/sh

rm -rf autom4te.cache
mkdir -p config/m4 config/aux 
autoreconf -iv || exit 1
rm -rf autom4te.cache


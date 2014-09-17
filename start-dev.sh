#!/bin/sh

cd `dirname $0`
exec iex --sname eliflow -S mix

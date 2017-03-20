#!/bin/sh

if [ "x`which expect`" == "x" ];then
	sudo apt-get install -y expect
fi

which expect
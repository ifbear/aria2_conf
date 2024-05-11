#!/bin/sh

if [[ -e "$3.aria2" ]]; then
	echo $3
	rm "$3.aria2" 
	rm "$3"
elif [[ -e "$3.torrent" ]]; then
	echo $3
	rm "$3.torrent" 
	rm "$3"
fi
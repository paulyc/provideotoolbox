#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	echo "Usage: $0 <URI to playlist.m3u8>" 2>&1
	echo "Writes reassembled mpeg2 transport stream described in playlist.m3u8 to stdout" 2>&1
	exit 1
fi

echo 'tsarray=(' > sourceme
curl $1 >> sourceme
echo ')' >> sourceme

. sourceme

protohostpart=$( echo $1 | sed 's/^\(.*:\/\/[^\/]*\)\/.*$/\1/' )

for ts in ${tsarray[@]}; do
curl "${protohostpart}${ts}"
done


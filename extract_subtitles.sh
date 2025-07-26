#!/bin/bash
#set -x
file_extension=$(echo ${1##*.})
file_name=$(basename "${1}" .${file_extension})
file_directory=$(dirname "${1}")

# List all audio streams
streams=$(ffprobe -loglevel error -select_streams s -show_entries stream=index,codec_name:stream_tags=language -of "csv=nk=1:p=0" "$1")

echo Processing ${file_name}, found $(echo "${streams}" | wc -l) "stream(s)"

for stream in $streams; do
  IFS=',' read -ra parts <<< "$stream";unset IFS
  #Index "${parts[0]}"
  #Codec "${parts[1]}"
  #Lang "${parts[2]}
  if [ -z ${offset} ]; then offset=${parts[0]}; fi
    output=${file_name}.$(expr ${parts[0]} - ${offset}).${parts[2]}.mkv

    if [ -f "${file_directory}/${output}" ]; then echo "${file_directory}/${output} already processed, skipped"; continue; fi

    ffmpeg -loglevel quiet -stats -i "${1}" -c copy -map 0:s:$(expr ${parts[0]} - ${offset}) "${file_directory}/${output}"

    echo "Written ${file_directory}/${output}"
done

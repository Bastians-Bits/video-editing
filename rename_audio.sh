#!/bin/bash
###
# Rename an audio stream without processing the video
#
# Requires:
# - ffprobe
# - ffprobe
#
# Takes the input file as the first argument
###

file_extension=$(echo ${1##*.})

# List all audio streams
ffprobe -v error -select_streams a -show_entries stream=index:stream_tags=language:stream=channel_layout -of csv=p=0 "$1"

printf "Input the index of the stream to rename:\n"
read stream_index
printf "Input the new langauge code:\n"
read language_code

ffmpeg -i "$1" -metadata:s:${stream_index} language=${language_code} -codec copy -map 0 "${1%.${file_extension}}.tmp.${file_extension}"

mv "${1%.${file_extension}}.tmp.${file_extension}" "$1"

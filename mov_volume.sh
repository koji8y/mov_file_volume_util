#!/bin/bash
usage() {
  echo "Usage: $(basename $0) target.MOV" 1>&2
}
case "$1" in
  *.MOV|*.mov|*.m4a) ;;
  *) usage; exit 1 ;;
esac
for target in $@; do
  case "${target}" in
    *.MOV|*.mov|*.m4a) ffmpeg -i "${target}" -af "volumedetect" -f null /dev/null 2>&1 | fgrep _volume: | sed -e 's/^/'"${target}: "'/' ;;
    *) ;;
  esac
done

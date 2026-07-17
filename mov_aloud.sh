#!/bin/bash
usage() {
  echo "Usage: $(basename $0) target.MOV times_for_aloud_in_real_or_int_number" 1>&2
}
case "$1" in
  *.MOV|*.mov|*.m4a) ;;
  *) usage; exit 1 ;;
esac
case "$(echo "$2" | sed -e 's/[^0-9.]//')" in
  "") usage; exit 1 ;;
  "$2") ;;
  *) usage; exit 1 ;;
esac
times="$2"
case "${times}" in
  *.*) ;;
  *) times="${times}.0" ;;
esac
kern="${1%%.MOV}"
kern="${kern%%.mov}"
kern="${kern%%.m4a}"
ext="${1##*.}"
out="${kern}_vx${2}.${ext}"

set -ex
ffmpeg -i "$1" -c:v copy -af "volume=${times}" "${out}"
set +ex
echo ''
echo "created: ${out}"

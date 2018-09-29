#!/usr/bin/env bash

GENERATED="./generated"
RESOURCE="./rsc"

valsi="${1:?}"

pad3(){
  number="${1:?}"
  printf %03d "${number}"
}

extractSource(){
  line="${1:?}"
  echo "${line/;*/}"
}

extractTarget(){
  line="${1:?}"
  echo "${line/*;/}"
}

count=0
while IFS='' read -r line || [[ -n "$line" ]]; do
  echo "Rendering audio for: $line"
  index=$(pad3 "${count}")
  french=$(extractTarget "${line}")
  lojban=$(extractSource "${line/;*/}")
  pico2wave -l fr-FR -w "${GENERATED}/${valsi}_fr_${index}.wav" "${french}"
  espeak -v jbo "${lojban}" -w "${GENERATED}/${valsi}_jbo_${index}.wav"
  count=$((count+1))
done < "${RESOURCE}/${valsi}.dsv"

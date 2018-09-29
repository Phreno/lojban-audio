#!/usr/bin/env bash

valsi="${1:?}"

echo "rendering translation"

for jbobau in $(find -path "*generated*" -name "*jbo*"); do
  output="${jbobau/jbo_/}"
  output="${output/generated/computed}"
  output="${output/\.wav/}"
  french="${jbobau/jbo/fr}"

  echo "rendering ${output}"
  sox "${french}" --rate 22050 "tmp.wav"
  mv "tmp.wav" "${french}"
  sox "${jbobau}" "${french}" "${output}.jbo-fr.wav"
  sox "${french}" "${jbobau}" "${output}.fr-jbo.wav"
done

echo "rendering ${valsi} jbo->fr"
sox $(ls ./computed/*jbo-fr*) "./dist/${valsi}.jbo-fr.wav"
echo "rendering ${valsi} fr->jbo"
sox $(ls ./computed/*fr-jbo*) "./dist/${valsi}.fr-jbo.wav"
echo "rendering ${valsi} all"
sox $(ls ./computed/*) "./dist/${valsi}.wav"

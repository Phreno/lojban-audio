#!/usr/bin/env bash

valsi="${1:?}"

./flush.sh
./extract-wav.sh "${valsi}"
./render-translation.sh "${valsi}"

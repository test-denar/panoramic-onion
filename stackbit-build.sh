#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://ca9e9699.ngrok.io/project/5dd51492b78e9086edc90fe1/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://ca9e9699.ngrok.io/pull/5dd51492b78e9086edc90fe1 
fi
curl -s -X POST https://ca9e9699.ngrok.io/project/5dd51492b78e9086edc90fe1/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://ca9e9699.ngrok.io/project/5dd51492b78e9086edc90fe1/webhook/build/publish > /dev/null

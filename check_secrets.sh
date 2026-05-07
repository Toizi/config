#!/usr/bin/env bash

SECRETS_DIR="/home/mg/data/secrets"

echo "checking secrets in ${SECRETS_DIR}"
if [[ ! -f "${SECRETS_DIR}/gotify_url" ]] ;
then
  echo "gotify_url missing"
  echo "verify using 'gotify-send 5 title message'"
fi

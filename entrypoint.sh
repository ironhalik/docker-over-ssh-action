#!/bin/bash -e

KEY_FILE=/root/.ssh/id_rsa

echo "${INPUT_KEY}" > ${KEY_FILE}
chmod 600 ${KEY_FILE}
if ! ssh-keygen -l -f ${KEY_FILE} > /dev/null 2>&1; then
  echo "The key seems to be invalid. Try checking it with:"
  echo "ssh-keygen -l -f keyfile.pem"
  exit 2
fi

# Expand variables hidden within input parameters
export INPUT_HOST=$(eval echo "${INPUT_HOST}")
export INPUT_USER=$(eval echo "${INPUT_USER}")
export INPUT_PORT=$(eval echo "${INPUT_PORT}")

export DOCKER_HOST="ssh://${INPUT_USER}@${INPUT_HOST}:${INPUT_PORT}"

echo "${INPUT_SCRIPT}" | while read line; do
  eval "${line}"
done

unset DOCKER_HOST
rm ${KEY_FILE}

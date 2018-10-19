#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ALIAS=${1:-emerald-squad}
PIPELINE_NAME=${2:-sonar-scanner}

fly -t "${ALIAS}" sp -p "${PIPELINE_NAME}" -c $DIR/pipeline.yml --non-interactive 

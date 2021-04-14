#!/bin/bash

# exit immediately when a command fails
set -e

# abort on attempting to use an undefined variable (hello Valve! :))
set -u

# set exitcode of a pipe chain to the exit code of the rightmost
# command not exiting with zero, if there are any
# in combination with -e this aborts on failure within a pipe chain
set -o pipefail

# make functions inherit ERR-traps, so that they fire when set -e takes effect there
set -E

./templater.sh
yarn run build
aws s3 sync dist "s3://$S3_BUCKET" --delete --acl public-read

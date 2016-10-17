#!/usr/bin/env bats

setup() {
  declare DEVOKU_SHARE_DIR="$BATS_TMPDIR/devokutestapp"
  declare DEVOKU_LOCAL_PREFIX="$DEVOKU_SHARE_DIR/.devoku"
  mkdir -p $DEVOKU_SHARE_DIR $DEVOKU_LOCAL_PREFIX
  export DEVOKU_SHARE_DIR=$DEVOKU_SHARE_DIR
  export DEVOKU_LOCAL_PREFIX=$DEVOKU_LOCAL_PREFIX
  run bash devoku env paths
}

@test "build without git" {
  declare DEVOKU_SHARE_DIR="$BATS_TMPDIR/devokutestapp"
  declare DEVOKU_LOCAL_PREFIX="$BDEVOKU_SHARE_DIR/.devoku"
  export DEVOKU_SHARE_DIR=$DEVOKU_SHARE_DIR
  export DEVOKU_LOCAL_PREFIX=$DEVOKU_LOCAL_PREFIX
  run bash devoku build
  echo "$lines"
  [ "$status" -eq 110 ]
}

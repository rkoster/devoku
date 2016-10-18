#!/usr/bin/env bats
load testapp_helper

setup() {
  setup-testapp
  bash $DEVOKU env new
}

@test "build without git repository" {
  run bash $DEVOKU build
  [ "$status" -eq 111 ]
}

teardown() {
  teardown-testapp
}

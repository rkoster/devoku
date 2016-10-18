#!/usr/bin/env bats
load testapp_helper

setup() {
  setup-testapp
}

@test "build without env" {
  run bash $DEVOKU build
  [ "$status" -eq 10 ]
}

teardown() {
  teardown-testapp
}

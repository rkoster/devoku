#!/usr/bin/env bats
load testapp_helper

setup() {
  setup-testapp
  install-django-project
  commit
  bash $DEVOKU env new
}

@test "build" {
  run bash $DEVOKU build
  [ "$status" -eq 0 ]
}

@test "build second time" {
  run bash $DEVOKU build
  [ "$status" -eq 0 ]
}

teardown() {
  teardown-testapp
}

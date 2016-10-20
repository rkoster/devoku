#!/usr/bin/env bats

setup() {
  TEMPLATES=ubuntu-16.04-x86_64.json
  cd $PWD/packer
}

@test "packer validate" {
  for t in $TEMPLATES
  do
  	run packer validate $t
    [ "$status" -eq 0 ]
  done
}

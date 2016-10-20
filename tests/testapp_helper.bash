setup-testapp() {
  TEST_DIR=$BATS_TMPDIR/devokutestapp
  teardown-testapp
  mkdir -p $TEST_DIR
  DEVOKU=$PWD/bin/devoku
  cd $TEST_DIR
}

teardown-testapp() {
  TEST_DIR=$BATS_TMPDIR/devokutestapp
  rm -rf $TEST_DIR || true
}

install-django-project() {
  virtualenv $TEST_DIR/.venv
  $TEST_DIR/.venv/bin/pip install django
  $TEST_DIR/.venv/bin/django-admin.py startproject --template=https://github.com/heroku/heroku-django-template/archive/master.zip --name=Procfile helloworld $TEST_DIR
}

commit() {
  tee $TEST_DIR/.gitignore -a > /dev/null <<EOF
.devoku
.venv
EOF
  (cd $TEST_DIR && git init && git add . && git commit -am "test")
}

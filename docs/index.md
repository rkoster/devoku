# Devoku

Herokuish development environment for just about any project.

## Getting started

### Prerequisites

- Up to date version of [Vagrant](https://www.vagrantup.com/).
- A project under Git version control.
- A valid Heroku project.

### Vagrantfile

Your Vagrantfile should contain the following:

```
Vagrant.configure(2) do |config|
  config.vm.box = "adaptivdesign/devoku"
  config.vm.synced_folder ".", "/vagrant"

  ...

  # Dyno http port
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  # S3 http port
  config.vm.network "forwarded_port", guest: 4569, host: 4569

end
```

### Using Devoku

Once your Vagrant machine is provisioned, you will have an Ubuntu 16.04
based machine, with the latest Docker version installed and access to
the Devoku cli commands.

```
$ vagrant ssh
$ cd /vagrant
```

### Setup environment variables

The first thing you want to do is setup a new Devoku environment, this is
a file containing environment variables required by your App. Devoku creates
this file for you using the `devoku env new` command.

```
$ devoku env new
$ devoku env print
```

### Build the image

If your build requires certain environment variables make sure to set them
before building. Once this is done we can start to build our Herokuish Docker
image.

```
$ devoku build
```

### Setup backing services

Before running the app, we need to ensure all backing services are running.
Most apps will require a Postgres Database, so lets provide the service.
Notice that when you created your environment, it automatically generated a
`DATABASE_URL` for you. We are going to start a Postgres server and create an
empty database with just the following commands:

```
$ devoku service postgres up
$ devoku pg createdb
```

### Run your app

Everything is set, now simply run:

```
$ devoku web
```

This starts a single web dyno available at [http://localhost:8000](http://localhost:8000)

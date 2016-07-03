[![Build Status](https://travis-ci.org/octopusinvitro/uno.svg?branch=master)](https://travis-ci.org/octopusinvitro/uno)
[![build status](https://gitlab.com/me-stevens/uno/badges/master/build.svg)](https://gitlab.com/me-stevens/uno/commits/master)
[![Coverage Status](https://coveralls.io/repos/github/octopusinvitro/uno/badge.svg?branch=master)](https://coveralls.io/github/octopusinvitro/uno?branch=master)

# Readme

A Sinatra implementation of the game UNO.


## How to use this project

This is a Ruby project.
You will need to tell your favourite Ruby version manager to set your local Ruby version to the one specified in the `.ruby-version` file.

For example, if you are using [rbenv](https://cbednarski.com/articles/installing-ruby/):

1. Install the right Ruby version:
```bash
$ rbenv install < VERSION >
$ rbenv rehash
```
1. Move to the root directory of this project and type:
```bash
$ rbenv local < VERSION >
$ ruby -v
```

You will also need to install the `bundler` gem, which will allow you to install the rest of the dependencies listed in the `Gemfile` file of this project.

```bash
$ gem install bundler
$ rbenv rehash
```


### Folder structure

* `bin `: Executables
* `lib `: Sources
* `spec`: Tests


### To initialise the project

```bash
$ bundle install
$ bundle exec rake
```


### To run the tests

```bash
$ bundle exec rspec --color
```


### Another way of running them

```bash
$ bundle exec rake
```


### To run the app

Make sure that the `bin/app` file has execution permissions:

```bash
$ chmod +x bin/app
```

Then just type:

```bash
$ bin/app
```

Open your browser and go to http://localhost:4567/


### Another way of running it

Update the `config.ru` file, then type

```bash
$ rerun rackup
```

Open your browser and go to http://localhost:9292/

The `rerun` gem watches for changes in your files and reloads the server.


## Comments

It's funny how constants are not constant in Ruby.
In the `UnoServer` class, I had initially `MAX_PLAYERS = 4` and `MAX_CARDS = 7`.
I had to change them to `attr_reader :max_players, :max_cards` because the constants can be overwritten.


## To do

* [ ] What if a player's name already exists?
* [ ] Possible errors?
* [x] `UnoServer`'s boolean methods don't have a `?`
* [ ] Find a way to implement command-query separation in `UnoServer`'s boolean methods


## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License

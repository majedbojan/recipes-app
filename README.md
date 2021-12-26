# RecipesApp

Recipes is an application that helps you find a recipe that you can prepare with what you have at home

## Target audience

- People who are proficient cooks and are just looking for an inspiration and new ideas
- People who are in need of guidance with cooking

## Scope

# Developer Guide

## Requirements

- Ruby 3.0.1
- PostgreSQL 14+
- Redis 6+

### Setup

To start development, clone the project

```powershell
$ git clone git@github.com:majedbojan/recipes-app.git
$ cd recipes-app
```

Then run

```powershell
$ bin/setup
```

### Seed

```powershell
$ rails db:seed
```

Note: Total recipes are 9500, please feel free to import as less as you need by changing the `NO_OF_RECIPES` value in `db/seeds.rb`

### Branches

Note: `develop` is the base branch for development, git tree should be `develop` -> `main`

### Environemtn

- `development`: Development environment
- `test`: Used to run unit test
- `production`: End user environment.

### Test cases
```powershell
bundle exec rspec spec/
```
### DB Design

```ruby
# TODO: DB Diagram
```

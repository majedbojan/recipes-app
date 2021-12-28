# RecipesApp

Recipes is an application that helps you find a recipe that you can prepare with what you have at home

## Target audience

- People who are proficient cooks and are just looking for an inspiration and new ideas
- People who are in need of guidance with cooking

## Live demo

[heroku live](https://recipe-app-test.herokuapp.com/)

### Credentials

- user: `user@recipe.app`
- admin: `admin@recipe.app`

## Scope

### Admin (Admin pannel)

- [x] Login, Sign up, Forgot password
- [x] List, show, create, update, and search of recipe
- [x] List, show, and approve or reject recipe requests (Recipes added by users will not appear on the app unless admins approve)
- [x] List, show, update, and search of user

### Consumer (Web and API's)

Web:

- [x] Login, Sign up, Forgot password (Users can list, show recipes without signing up)
- [x] List, and show recipe
- [x] Users can search and filter recipes by tags, ingredients, recipe name, recipe budget and difficulty options
- [x] Logged in user can recommend a recipe for peoples but will not appear in the app unless admin approve
- [x] Users can see feedbacks added by other users
- [ ] Logged in users can give feedback on the specific recipe

API:

- [x] List, show, filter recipe API's
- [x] List and feedback API's
- [x] List of tags API
- [x] List of ingredients API
- [x] Login API

### Documentation/collection

- [API Documentation](https://documenter.getpostman.com/view/1831165/UVRGD434)

- [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/6ba8f1062a920ab76dd4?action=collection%2Fimport)

# Developer Guide

## Dependencies

- Ruby 3.0.1
- PostgreSQL 14+
- Node

### Setup

To start development, clone the project

```powershell
$ git clone git@github.com:majedbojan/recipes-app.git
$ cd recipes-app
```

Then run

```powershell
bundle install
```

### Seed

```powershell
$ rails db:seed
```

Note: Total recipes are 9500, please feel free to import as less as you need by changing the `NO_OF_RECIPES` value in `db/seeds.rb`

### Branches

Note: `develop` is the base branch for development, git tree should be `develop` -> `main`

### Environemtens

- `development`: Development environment
- `test`: Used for unit test
- `production`: End user environment.

### Test cases

```powershell
bundle exec rspec spec/

# Output
Finished in 2.51 seconds (files took 5.96 seconds to load)
83 examples, 0 failures
```

### DB Design

![ERD](./docs/recipeAppDB.png)

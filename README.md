# Workflow management for Garlic Tech projects

[![Build Status](https://travis-ci.com/garlictech/garlictech-workflows-client.svg?token=PrxB3e9orjydN7XUbkZL&branch=master)](https://travis-ci.com/garlictech/garlictech-workflows-client)

The information below applies all the Garlic Tech projects.

## Installation

After cloning, do the usual

```npm install```

The instal process will create a `.env` file. Edit it, to add development setup. Probably the first thing is: uncomment the ```NODE_ENV=development``` line.

## Commands during development

Start a development web server, with livereload:

```npm start```

Build the project (in the ```dist``` directory):

```npm run build```

Run the unit tests:

```npm run unittest```

In development mode it will watch sources anr re-run tests on changes. In production mode, it runs it once.

Set up selenium (do in once):

```npm run protractor-setup```

Start selenium server for protractor tests:

```npm run protractor-start```

Execute e2e tests (selenium must be running):

```npm run e2e-tests```

### Gulp commands

They are really done during development. Available gulp commands:

```gulp help```

You can find some more info in https://github.com/garlictech/garlictech-workflows-common.

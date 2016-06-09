# Workflow management for Garlic Tech projects

The information below applies all the Garlic Tech projects.

## Installation

After cloning, do the usual

```npm install```

The instal process will create a `.env` file. Edit it, to add development setup. Probably the first thing is: uncomment the ```NODE_ENV=development``` line.

## Commands during development

Start a development web server, with livereload:

```npm start```

Build the project (in the ```dist``` directory):

```npm run-script build```

Run the unit tests:

```npm run-script unittest```

In development mode it will watch sources anr re-run tests on changes. In production mode, it runs it once.

Set up selenium (do in once):

```npm run-script protractor-setup```

Start selenium server for protractor tests:

```npm run-script protractor-start```

Execute e2e tests (selenium must be running):

```npm run-script e2e-tests```


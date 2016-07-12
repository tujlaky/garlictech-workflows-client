# Workflow management for Garlic Tech projects

[![Build Status](https://travis-ci.com/garlictech/garlictech-workflows-client.svg?token=PrxB3e9orjydN7XUbkZL&branch=master)](https://travis-ci.com/garlictech/garlictech-workflows-client)

The information below applies all the Garlic Tech projects.

## Installation

After cloning, do the usual

```npm install```

The instal process will create a `.env` file. Edit it, to add development setup. Probably the first thing is: uncomment the ```NODE_ENV=development``` line. Mind, that the e2e test bundle is built only if this environment variable is set.

## Commands during development

 * Start a development web server, with livereload:

```npm start```

 * Build the project (in the ```dist``` directory):

```npm run build```

 * Run the unit tests:

```npm run unittest```

In development mode it will watch sources anr re-run tests on changes. In production mode, it runs it once.

* Important *: Currently, karma requires that the dist folder exists, with the compiled project. So, before running unittests, make sure that you issued `npm run build` at least once.

 * Set up selenium (do in once):

```npm run protractor-setup```

Postinstall tries to execute this step. Use this command explicitly it it failed for some reason.

* Start selenium server for protractor tests:

```npm run protractor-start```

* Execute e2e tests (selenium must be running):

```npm run e2e-tests```

Before running it, you have to start selenium (```npm run protractor-start```) and a web server serving the project (```npm start```). Also, ensure, that the webpack bundle containing the test app is built.

* Watch source changes

```npm run start-watch```

This command watches source files and rebuilds the project if it changes. It does not start development server. The command is useful when you develop ionic applications with livereload: project is built in the dist folder, and the emulator can reload the app.

* Profile webpack build

```npm run webpack-profile```

It produces a ```webpack-stats.json``` file. Upload it to the [Webpack analyse tool](http://webpack.github.io/analyse/) and <enjoy class=""></enjoy>

### Gulp commands

They are really done during development. Available gulp commands:

```gulp help```

You can find some more info in https://github.com/garlictech/garlictech-workflows-common.

## Content of package.json

* `main` filed should be present: it should be the index file that is the main entry point of the package. Karma, etc. uses it!

* A special construct may be present, here is an example:

```
"garlic": {
  "type": "module",
  "unittest": "./src/test/unit/test.coffee"
}
```

 * ```type```: Must be "module" if the package is an (Angular) module. In this case, the index.html in the e2e test will be used, where you can implement your e2e tests. Otherwise, the package is an application package, it has ```src/index.html```, so ```npm start``` uses that.

 * ```unittest```: The entry point of the unit tests. By default, it is ```./src/test/unit/test.coffee```. Change it if you have vanilla Javascript, etc. project.

* ```config``` field
 
 * ```port```: webpack dev server uses this port (so, it is available as ```npm_package_config_port``` environment variable)


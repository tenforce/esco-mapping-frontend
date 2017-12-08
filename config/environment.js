/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'mapping-platform-ui',
    environment: environment,
    baseURL: '/esco/mapping/',
    locationType: 'auto',
    filters: [
      {
        name: "To be mapped",
        id: "cede3dd1-dc27-4b65-a90e-d8a54603fa14",
        variables: ['effort', 'direction']
      },
      {
        name: "To be reviewed",
        id: "7f46d3fc-4b62-4119-8b92-902b7220a956",
        variables: ['effort', 'direction']
      },
      {
        name: "To be approved",
        id: "4e8fc305-82fe-4228-8bd1-1194c1018ffb",
        variables: ['effort', 'direction']
      },
      {
        name: "Concepts with more than one exact match",
        id: "44fbf5e5-42f9-4891-8346-e4f8e17c5559",
        variables: ['effort', 'direction']
      }
    ],
    contentSecurityPolicy: {
      'default-src': "'none'",
      'script-src': "'self' 'unsafe-eval' https://*.googleapis.com http://*.googleapis.com https://cdn.polyfill.io/v2/polyfill.min.js?features=Intl.~locale.en",
      'font-src': "'self' maxcdn.bootstrapcdn.com http://fonts.gstatic.com https://fonts.gstatic.com",
      'connect-src': "'self' http://*.googleapis.com https://*.googleapis.com",
      'img-src': "'self' *",
      'style-src': "'self' maxcdn.bootstrapcdn.com 'unsafe-inline' http://fonts.googleapis.com https://fonts.googleapis.com",
      'media-src': "'self'"
    },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
    mapping: {
      defaultLanguage: 'en',
      instanceTitle: 'Mapping Platform Demo'
    }
  };

  if (environment === 'development') {
    ENV.baseURL = '/';
    locationType= 'auto';

    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }
  ENV['ember-simple-auth'] = {
    authenticationRoute: 'sign-in',
    routeAfterAuthentication: 'index'
  };

  return ENV;
};

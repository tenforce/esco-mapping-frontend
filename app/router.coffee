`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

unless config.baseURL == "/"
  Ember.$.ajaxSetup
    beforeSend: (xhr, options) ->
      options.url = config.baseURL + options.url;

Router.map ->
  @route 'concepts', { path: '/concepts/:effort' }, ->
    @route 'browse', { path: 'browse' }, ->
      @route 'show', { path: ':id' }
      @route 'index', { path: '/' }
    @route 'admin', { path: 'extra' }
  @route 'sign-in'
  @route 'profile'
  @route 'index', {path: ''}



`export default Router;`

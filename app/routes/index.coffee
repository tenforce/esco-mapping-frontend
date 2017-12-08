`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

IndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    taxonomiesSelected: (params) ->
      @transitionTo("concepts.browse", params.effort)

`export default IndexRoute`

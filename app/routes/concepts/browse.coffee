`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ConceptsBrowseRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    filter:
      refreshModel: false
  model: (params, transition) ->
    # ?? just model for is not allowed... ok then
    effort: this.modelFor('concepts')


`export default ConceptsBrowseRoute`

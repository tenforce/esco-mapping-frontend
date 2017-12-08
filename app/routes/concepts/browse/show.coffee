`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ConceptsShowRoute = Ember.Route.extend AuthenticatedRouteMixin,
  hierarchyService: Ember.inject.service()
  model: (params, transition) ->
    Ember.RSVP.hash
      concept: @store.findRecord('concept', params.id)
      organization: this.set 'organization', this.modelFor('concepts')
  afterModel: (model,transition) ->
    @set 'hierarchyService.target', Ember.get(model, 'concept.id')


`export default ConceptsShowRoute`

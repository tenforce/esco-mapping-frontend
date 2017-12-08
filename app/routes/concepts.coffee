`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ConceptsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    inverted:
      refreshModel: true
  mappingEffort: Ember.inject.service()
  model: (params) ->
    options=
      "filter[id]": (params.effort)
      "include": "from,to"
    @get('store').query('mappingEffort', options).then (results) =>
      result = results?.get('firstObject')

      Ember.RSVP.hash(
        from: result.get('from')
        to: result.get('to')
      ).then (hash) =>
        @set 'mappingEffort.effort', result
        @set 'mappingEffort.from', result.get('from')
        @set 'mappingEffort.to', result.get('to')
        @set 'mappingEffort.inverted', (params.inverted == "true")
        @get 'mappingEffort'
        hash

`export default ConceptsRoute`

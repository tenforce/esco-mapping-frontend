`import Ember from 'ember'`

ConceptsBrowseController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  showFilter: Ember.computed 'user.showFilter', ->
    @get('user.showFilter') == "yes"
  mappingEffort: Ember.inject.service()
  queryParams: ['filter']
  actions:
    activateItem: (node) ->
      @transitionToRoute 'concepts.browse.show', node.get('id'), { queryParams: inverted: @get('mappingEffort.inverted')}
    switchHierarchies: ->
      effort=@get 'mappingEffort.effort.id'
      @transitionToRoute "/concepts/#{effort}/browse?inverted=#{not @get('mappingEffort.inverted')}"


`export default ConceptsBrowseController`

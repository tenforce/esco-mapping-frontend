`import Ember from 'ember'`

ConceptMappingComponent = Ember.Component.extend
  classNames: ["mapping"]
  tagName: "li"
  mappingEffort: Ember.inject.service()
  inverseInverted: Ember.computed.not 'mappingEffort.inverted'
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  userIsReviewer: Ember.computed.alias 'currentUser.userIsReviewer'
  userIsReviewerTester: Ember.computed.alias 'currentUser.userIsReviewerTester'
  watcher: Ember.inject.service("mapped-concepts-watcher")
  mappingActions: [
    { name: "removed", icon: "trash-o", tooltip: "delete mapping"},
    { name: "approved", icon: "check", tooltip: "confirm mapping"},
    { name: "rejected", icon: "times", tooltip: "reject mapping"}

  ]
  mappingTypes: Ember.computed 'origin.preflabel', 'isInverted', ->
    @get('origin.preflabel').then (target) =>
      if @get 'isInverted'
        [
          { name: "exact", label: "Match", match: "exact" },
          { name: "broader", label: "More specific than #{target}", match: "narrow" }
          { name: "narrow", label: "More general than #{target}", match: "broad" }
        ]
      else
        [
         { name: "exact", label: "Match", match: "exact" },
         { name: "broader", label: "More specific than #{target}", match: "broad" },
         { name: "narrow", label: "More general than #{target}", match: "narrow" }
        ]
  other: Ember.computed 'mapping.from', 'mapping.to', 'origin', ->
    from = @get('mapping.from')
    to = @get('mapping.to')
    if not @get 'isInverted'
      to
    else
      from
  isInverted: Ember.computed 'mapping.from.id', 'origin.id', ->
    @get('mapping.from.id') != @get 'origin.id'
  canChangeStatus: (current, status) ->
    if (@get('userIsReviewer') or @get('userIsReviewerTester'))
      return true
    else
      (((status == "removed") or status == "rejected") and (current == "rejected")) or
      ((status == "removed") and (current == "todo"))
  actions:
    selectMappingStatus: (mapping, status) ->
      current = mapping.get 'status'
      if not @canChangeStatus(current,status)
        return

      if status == current
        mapping.set 'status', 'todo'
      else if status == 'removed'
        mapping.set 'status', 'removed'
        mapping.set 'matchType', 'no'
      else
        mapping.set 'status', status
      mapping.set('lastModifier', @get('user'))
      mapping.set('lastModified', new Date())

      mapping.save().then(
        =>
          @get('watcher').refresh()
      )
    selectMappingType: (mapping, type) ->
      if (mapping.get('status') != "todo") and not (@get('userIsReviewer') or @get('userIsReviewerTester'))
        return

      current = mapping.get 'matchType'
      mapping.set 'matchType', type.match
      mapping.set('lastModifier', @get('user'))
      mapping.set('lastModified', new Date())
      mapping.save()

`export default ConceptMappingComponent`

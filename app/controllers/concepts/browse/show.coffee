`import Ember from 'ember'`
`import ComputeStatus from '../../../mixins/compute-status'`

ShowConceptController = Ember.Controller.extend ComputeStatus,

  collapsed: true
  toggleTooltip: Ember.computed 'collapsed', ->
    if @get('collapsed') is true then return "show more information"
    else "show less information"

  #
  defaultConceptDescriptionTagName: 'div'
  conceptDescriptionTagName: Ember.computed 'conceptDescription.tagName', 'defaultConceptDescriptionTagName', ->
    if @get 'conceptDescription.tagName' then @get 'conceptDescription.tagName'
    else @get 'defaultConceptDescriptionTagName'

  defaultConceptDescriptionClassNames: ['']
  conceptDescriptionClassNames: Ember.computed 'conceptDescription.classNames', 'defaultConceptDescriptionClassNames', ->
    if @get 'conceptDescription.classNames' then @get 'conceptDescription.classNames'
    else @get 'defaultConceptDescriptionClassNames'

  conceptDescriptionClass: Ember.computed 'concept.isOccupation', 'concept.isSkill', ->
    if @get 'concept.isOccupation' then return 'occupation'
    else if @get 'concept.isSkill' then return 'skill'
    else return 'occupation' # by default, for ISCO concepts

  conceptDescription:
    title:
      classNames: ['concept-header']
      tagName: 'div'
      label:
        classNames: ['label']
        tagName: 'div'
        type: 'property'
        name: 'iscoValue'
      target:
        classNames: ['main-title']
        tagName: 'h1'
        type: 'property'
        name: 'defaultPrefLabel'
    ,
    headings:
      classNames: ['concept-detail']
      tagName: 'div'
      values:
        [
          {
            classNames: ['concept-block concept-block-info']
            tagName: 'div'
            title:
              classNames: ['']
              tagName: 'h2'
              target:
                type: 'string'
                name: 'Concept info'
            items:
              values:
                [
                  {
                    classNames: ['inner inner-description']
                    tagName: 'div'
                    label:
                      tagName: 'h3'
                      type: 'string'
                      name: 'description'
                    target:
                      type:'component'
                      name: 'formatted-description'
                      properties:
                        name: 'defaultDescription'
                  },
                  {
                    classNames: ['inner inner-terms']
                    tagName: 'div'
                    label:
                      tagName: 'h3'
                      type: 'string'
                      name: 'Non-preferred terms'
                    target:
                      type: 'hasMany'
                      name: 'defaultAltLabels'
                      relation:
                        type: 'property'
                        name: 'literalForm'
                  },
                  {
                    classNames: ['inner inner-notes']
                    tagName: 'div'
                    label:
                      tagName: 'h3'
                      type: 'string'
                      name: 'Scope notes'
                    target:
                      type: 'property'
                      name: 'defaultScopeNote'
                  },
                  {
                    classNames: ['inner inner-code isco']
                    tagName: 'div'
                    label:
                      tagName: 'h3'
                      type: 'string'
                      name: 'ISCO-08'
                    target:
                      type: 'property'
                      name: 'iscoLabeledCode'
                  },
                  {
                    classNames: ['inner inner-code nace']
                    tagName: 'div'
                    label:
                      tagName: 'h3'
                      type: 'string'
                      name: 'NACE code'
                    target:
                      type: 'property'
                      name: 'naceCode'
                  }
                ]
          },
          {
            classNames: ['concept-block concept-block-related']
            tagName: 'div'
            title:
              classNames: ['']
              tagName: 'h2'
              target:
                type: 'string'
                name: 'Related skills / competences'
            items:
              values:
                [
                  {
                    target:
                      type:'component'
                      name:'show-skills'
                      tagName: 'div'
                      classNames: ['inner inner-skills']
                      properties:
                        title: 'Essential'
                        skillRelation: 'essentialSkills'
                  },
                  {
                    target:
                      type:'component'
                      name:'show-skills'
                      tagName: 'div'
                      classNames: ['inner inner-skills']
                      properties:
                        title: 'Optional'
                        skillRelation: 'optionalSkills'
                  }
                ]
          },
          {
            classNames: ['concept-block concept-block-related']
            tagName: 'div'
            title:
              classNames: ['']
              tagName: 'h2'
              target:
                type: 'string'
                name: 'Related knowledge'
            items:
              values:
                [
                  {
                    target:
                      type:'component'
                      name:'show-skills'
                      tagName: 'div'
                      classNames: ['inner inner-skills']
                      properties:
                        title: 'Essential'
                        skillRelation: 'essentialKnowledges'
                  },
                  {
                    target:
                      type:'component'
                      name:'show-skills'
                      tagName: 'div'
                      classNames: ['inner inner-skills']
                      properties:
                        title: 'Optional'
                        skillRelation: 'optionalKnowledges'
                  }
                ]
          },
          {
            classNames: ['concept-block concept-block-regulatory']
            tagName: 'div'
            title:
              classNames: ['']
              tagName: 'h2'
              target:
                type:  'string'
                name: 'Regulatory aspects'
            items:
              values:
                [
                  {
                    target:
                      type: 'property'
                      name: 'TODEFINE'
                  },
                  {
                    target:
                      type: 'property'
                      name: 'TODEFINE'
                  }
                ]
          }
        ]
  #

  concept: Ember.computed.alias 'model.concept'
  about: Ember.computed.alias('concept.id')
  mappingEffort: Ember.inject.service()
  currentUser: Ember.inject.service()
  user: Ember.computed.alias 'currentUser.user'
  userIsAdmin: Ember.computed.alias 'currentUser.userIsAdmin'
  userIsAdminTester: Ember.computed.alias 'currentUser.userIsAdminTester'
  userIsReviewer: Ember.computed.alias 'currentUser.userIsReviewer'
  userIsReviewerTester: Ember.computed.alias 'currentUser.userIsReviewerTester'
  userIsMapper: Ember.computed.alias 'currentUser.userIsMapper'
  userIsMapperTester: Ember.computed.alias 'currentUser.userIsMapperTester'
  watcher: Ember.inject.service("mapped-concepts-watcher")
  mappingStatus: 'In progress'
  readyObserver: Ember.observer 'originTaxonomy', 'targetTaxonomy', 'concept', ( ->
    originTaxonomy = @get('originTaxonomy')
    targetTaxonomy = @get('targetTaxonomy')
    concept = @get('concept')
    if originTaxonomy and targetTaxonomy and concept
      @get('targetMappingStatus').then (status) =>
        if status
          @set 'mappingStatus', status.get('status')
        else
          @set 'mappingStatus', 'In progress'
  ).on('init')
  conceptObserver: Ember.observer('concept', ->
    currentConcept = @get('concept')
    @set('mappingEffort.currentConcept', currentConcept)
  ).on('init')
  showDetailsObserver: Ember.observer 'user.showDetails', ( ->
    if @get('user.showDetails') == "yes"
      @set('collapsed', false)
    else
      @set('collapsed', true)
  ).on('init')
  targetTaxonomy: Ember.computed.alias 'mappingEffort.to'
  originTaxonomy: Ember.computed.alias 'mappingEffort.from'
  mappingStatusses: Ember.computed 'mappingStatus', 'userIsAdmin', 'userIsAdminTester', 'userIsReviewer', 'userIsReviewerTester', 'userIsMapper', 'userIsMapperTester', ->
    if (@get('userIsAdmin') or @get('userIsAdminTester'))
      [
        "Approved",
        "Rejected",
        "In progress",
        "Ready for review"
      ]
    else if (@get('userIsMapper') or @get('userIsMapperTester'))
      if @get('mappingStatus') == "In progress"
        ["Ready for review"]
      else
        []
    else if (@get('userIsReviewer') or @get('userIsReviewerTester'))
      if @get('mappingStatus') == "Ready for review"
        [
          "Approved",
          "Rejected"
        ]
      else
        []
    else
      [ @get('mappingStatus') ]
  findExistingMapping: (target) ->
    from = @get 'concept'
    inverted = @get 'mappingEffort.inverted'
    mappings = null
    targetLocation = null
    if inverted
      mappings = from.get 'mappingsTo'
      targetLocation = 'from'
    else
      mappings = from.get 'mappingsFrom'
      targetLocation = 'to'

    promises = mappings.map (mapping) ->
      mapping.get(targetLocation)
    Ember.RSVP.all(promises).then (targets) ->
      match = null
      targets.forEach (concept,index) ->
        if concept.get('id') == target.get('id')
          match = mappings.objectAt(index)
      match
  mappingStatusClass: Ember.computed 'mappingStatus', ->
    @get('mappingStatus').toLowerCase().split(" ").join("-")
  actions:
    toggleDetail: ->
      @toggleProperty("collapsed")
      false
    # Suggestion is passed as a parameter if we need to add a link between it and the mapping
    createMapping: (node, suggestion) ->
      from = @get 'concept'
      currentEffort = @get('mappingEffort.effort')
      @findExistingMapping(node).then (mapping) =>
        if mapping
          mapping.set 'matchType', 'exact'
          mapping.set 'status', 'todo'
          mapping.set 'fullScore', 1
          mapping.set 'lastModified', new Date()
          mapping.set 'lastModifier', @get('currentUser.user')
          mapping.set 'mappingEffort', currentEffort
        else
          inverted = @get 'mappingEffort.inverted'
          target = node
          origin = from
          if inverted
            target = from
            origin = node

          mapping = @store.createRecord 'mapping',
            mappingEffort: currentEffort
            matchType: 'exact'
            from: origin
            to: target
            status: 'todo'
            lastModifier: @get('currentUser.user')
            lastModified: new Date()
          origin.get('mappingsFrom').pushObject(mapping)
          target.get('mappingsTo').pushObject(mapping)

        mapping.save().then( =>
          @get('watcher').refresh()
          if suggestion
            suggestion.set('mapping', mapping)
            suggestion.set('status', 'hidden')
            suggestion.save()
            mapping.set('suggestion', suggestion)
        )


    deleteMapping: (node) ->
      @findExistingMapping(node).then (mapping) =>
        if mapping
          mapping.set 'matchType', 'no'
          mapping.set 'status', 'removed'
          mapping.set 'fullScore', 1

        mapping.save().then =>
          @get('watcher').refresh()

    acceptSuggestion: (suggestion) ->
      @get('store').findRecord('concept', suggestion.get('targetUuid')).then (result) =>
        @send('createMapping', result, suggestion)

    rejectSuggestion: (suggestion) ->
      if suggestion.get('status') is 'hidden'
        suggestion.set('status', 'shown')
      else
        suggestion.set('status', 'hidden')
      suggestion.save()

    changeStatus: (status) ->
      if not @get('mappingStatusses').contains status
        return
      @get('targetMappingStatus').then (current) =>
        @set 'mappingStatus', status
        if current
          current.set 'status', status
          current.save()
        else
          effort = @get('mappingEffort.effort')
          if effort
            myStatus = @get('store').createRecord 'mapping-state',
              status: status
              mappingEffort: effort
              concept: @get('concept')
            myStatus.save()
            @get('concept.mappingStates').pushObject(myStatus)

`export default ShowConceptController`

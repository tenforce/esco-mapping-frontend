`import Ember from 'ember'`
`import {languages} from '../utils/languages'`

CreateEffortComponent = Ember.Component.extend
  classNames: ['effort']
  locales: languages
  store: Ember.inject.service()
  sourceTaxonomy: undefined
  targetTaxonomy: undefined
  sourceTaxonomies: Ember.computed ->
    @get('store').findAll('taxonomy')
  sortedSourceTaxonomies: Ember.computed.sort 'sourceTaxonomies', (a, b) ->
      if a.get('preflabel') > b.get('preflabel') then return 1
      else if a.get('preflabel') < b.get('preflabel') then return -1
      else return 0
  targetTaxonomies: Ember.computed 'sourceTaxonomy', ->
    unless @get('sourceTaxonomy.id') then return undefined
    @get('store').findAll('taxonomy')
  sortedTargetTaxonomies: Ember.computed.sort 'targetTaxonomies', (a, b) ->
    if a.get('preflabel') > b.get('preflabel') then return 1
    else if a.get('preflabel') < b.get('preflabel') then return -1
    else return 0
  isAllowed: Ember.computed "sourceTaxonomy", "targetTaxonomy", 'selectedLocale', 'effortLabel',  ->
    if !Ember.isEmpty(@get('sourceTaxonomy')) and !Ember.isEmpty(@get('targetTaxonomy')) and @get('selectedLocale') and @get('effortLabel')
      true
    else
      false
  sourceTaxonomyIsSelected: Ember.computed 'sourceTaxonomy', ->
    if @get('sourceTaxonomy.id') then return true
    else return false
  selectedLocale: {title: "English", id: "en"}
  effortLabel: undefined
  actions:
    closeWindow: ->
      @sendAction('closeWindow')
    selectLocale: (locale) ->
      @set('selectedLocale', locale)
    selectSourceTaxonomy: (taxonomy) ->
      @set('sourceTaxonomy', taxonomy)
    selectTargetTaxonomy: (taxonomy) ->
      @set('targetTaxonomy', taxonomy)
    createEffort: ->
      effort = @get('store').createRecord('mapping-effort',
        status: 'todo'
        from: @get('sourceTaxonomy')
        to: @get('targetTaxonomy')
        locale: @get('selectedLocale.id')
        label: @get('effortLabel')
      )
      effort.save().then (eff) =>
        @sendAction('closeWindow')

`export default CreateEffortComponent`

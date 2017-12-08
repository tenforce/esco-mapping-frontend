`import DS from 'ember-data'`
`import ESCO from 'ember-esco-concept-description'`

Taxonomy = DS.Model.extend ESCO.ConceptScheme,
  children: Ember.computed.alias 'topConcepts'
  minScore: DS.attr('double')
  version: DS.attr('string')
  mappingTargets: DS.hasMany('taxonomy', {inverse: null})
  locale: DS.attr('string')

`export default Taxonomy`

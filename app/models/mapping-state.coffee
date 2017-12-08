`import DS from 'ember-data'`
MappingState = DS.Model.extend
  status: DS.attr('string')
  mappingEffort: DS.belongsTo('mapping-effort', {inverse: null})
  concept: DS.belongsTo('concept', {inverse: null})

`export default MappingState`


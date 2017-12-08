`import DS from 'ember-data'`

Mapping = DS.Model.extend
  status: DS.attr('string')
  matchType: DS.attr('string')
  lastModified: DS.attr('date')
  from: DS.belongsTo('concept', { inverse: null })
  to: DS.belongsTo('concept', { inverse: null})
  suggestion: DS.belongsTo('suggestion', { inverse: null})
  mappingEffort: DS.belongsTo('mapping-effort', { inverse: null})
  lastModifier: DS.belongsTo('user', { inverse: null })

`export default Mapping`

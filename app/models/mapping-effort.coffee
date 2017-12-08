`import DS from 'ember-data'`

MappingEffort = DS.Model.extend
  label: DS.attr()
  locale: DS.attr('string')
  from: DS.belongsTo('taxonomy', {inverse: null})
  to: DS.belongsTo('taxonomy', {inverse: null})
  mappings: DS.hasMany('mapping', {inverse: null})
  mappingStates: DS.hasMany('mapping-state', {inverse: null})

`export default MappingEffort`

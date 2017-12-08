`import DS from 'ember-data'`

User = DS.Model.extend
  name: DS.attr('string')
  showMappings: DS.attr('string')
  showDetails: DS.attr('string')
  showFilter: DS.attr('string')
  showCompletedSuggestions: DS.attr('string')
  groups: DS.hasMany('group', {inverse: null})

`export default User`

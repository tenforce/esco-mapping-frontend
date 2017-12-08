`import DS from 'ember-data'`

Account = DS.Model.extend
  username: DS.attr('string')
  user: DS.belongsTo('user', {inverse: null})

`export default Account`

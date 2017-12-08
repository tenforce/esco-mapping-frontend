`import Ember from 'ember'`

KpiBarComponent = Ember.Component.extend
  percentage: Ember.computed 'value', 'total', ->
    Ember.String.htmlSafe("width:#{@get('value')/@get('total')*100}%;")

`export default KpiBarComponent`

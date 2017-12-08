`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'mapping-types-chart', 'Integration | Component | mapping types chart', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{mapping-types-chart}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#mapping-types-chart}}
      template block text
    {{/mapping-types-chart}}
  """

  assert.equal @$().text().trim(), 'template block text'

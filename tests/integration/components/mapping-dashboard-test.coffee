`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'mapping-dashboard', 'Integration | Component | mapping dashboard', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{mapping-dashboard}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#mapping-dashboard}}
      template block text
    {{/mapping-dashboard}}
  """

  assert.equal @$().text().trim(), 'template block text'

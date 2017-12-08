`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'mapping-status', 'Integration | Component | mapping status', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{mapping-status}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#mapping-status}}
      template block text
    {{/mapping-status}}
  """

  assert.equal @$().text().trim(), 'template block text'

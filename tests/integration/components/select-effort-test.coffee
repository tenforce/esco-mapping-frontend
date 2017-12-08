`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'select-effort', 'Integration | Component | select effort', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{select-effort}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#select-effort}}
      template block text
    {{/select-effort}}
  """

  assert.equal @$().text().trim(), 'template block text'

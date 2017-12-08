`import Ember from 'ember'`
`import FetchHierarchiesMixin from '../../../mixins/fetch-hierarchies'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | fetch hierarchies'

# Replace this with your real tests.
test 'it works', (assert) ->
  FetchHierarchiesObject = Ember.Object.extend FetchHierarchiesMixin
  subject = FetchHierarchiesObject.create()
  assert.ok subject

`import Ember from 'ember'`
`import HierarchyConfigMixin from '../../../mixins/hierarchy-config'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | hierarchy config'

# Replace this with your real tests.
test 'it works', (assert) ->
  HierarchyConfigObject = Ember.Object.extend HierarchyConfigMixin
  subject = HierarchyConfigObject.create()
  assert.ok subject

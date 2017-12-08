`import Ember from 'ember'`
`import ComputeStatusMixin from '../../../mixins/compute-status'`
`import { module, test } from 'qunit'`

module 'Unit | Mixin | compute status'

# Replace this with your real tests.
test 'it works', (assert) ->
  ComputeStatusObject = Ember.Object.extend ComputeStatusMixin
  subject = ComputeStatusObject.create()
  assert.ok subject

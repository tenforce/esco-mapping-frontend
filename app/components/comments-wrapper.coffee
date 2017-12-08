`import Ember from 'ember'`

CommentsWrapperComponent = Ember.Component.extend
  moveComments: ->
    offsetFromWindow = Ember.$(window).scrollTop()
    top = Math.max(0, (Ember.$('.main-header').height() + 20 - offsetFromWindow))
    if offsetFromWindow < 96
      top += 20
    Ember.$('.sidebar').css('margin-top', "#{top}px") 
  didInsertElement: ->
    Ember.$(window).on('scroll', @moveComments)
    @moveComments()
  willDestroyElement: ->
    Ember.$(window).off('scroll', @moveComments)
    

`export default CommentsWrapperComponent`

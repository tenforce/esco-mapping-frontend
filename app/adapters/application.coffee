`import Ember from 'ember'`
`import DS from 'ember-data'`
`import HasManyQuery from 'ember-data-has-many-query'`
`import config from '../config/environment';`

Adapter = DS.JSONAPIAdapter.extend HasManyQuery.RESTAdapterMixin,
  init: ->
    @_super(arguments...)
    unless config.baseURL == "/"
      this.host = config.baseURL

  maxRetries: 5 # TODO let this be set in a config file and Ember.compute this
  messageDelay: 10000 # 10s of delay
  ajax: ->
    livesLeft = @get 'maxRetries'
    args = arguments
    original = @_super
    adapter = this
    originalData = args[2]?.data
    if originalData
      originalData = originalData

    # define a new method that uses a promise to sleep
    sleep = (time) ->
      new Promise (resolve) ->
        setTimeout(resolve, time)

    # retries the original function
    retry = ->
      # apparently ajax modifies original data...
      if originalData
        args[2].data = originalData
      original.apply(adapter, args).catch (error) ->
        livesLeft -= 1
        if livesLeft > 0
          sleep(500).then ->
            retry()
        else
          adapter._alertConnectionError(error)

    retry()

# alerts the user of a connection error and returns the error
  _alertConnectionError: (error) ->
    now = new Date()
    if Adapter.lastMessage and (now.getTime() - Adapter.lastMessage.getTime() < @get('messageDelay'))
# lets not bother the user again...
      return

    Adapter.lastMessage = now

    if result?.errors?[0]?.status == "0"
      alert("You are offline");
    else
      alert("You appear to be offline\n\nPlease reload the application. \n\nIf the problem persists, please contact your administrator.");
    error

Adapter.lastMessage = null

`export default Adapter`

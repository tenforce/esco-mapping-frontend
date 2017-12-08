`import Ember from 'ember'`
`import layout from '../templates/components/formatted-description'`

FormattedDescriptionComponent = Ember.Component.extend
  layout: layout
  bulletClass: "inner-bullet"
  listingClass: "inner-listing"
  inlineListClass: "inline-list"
  classNames: [""]

  checkDescription: Ember.observer('description', ()->
    if Ember.isEmpty @get 'description'
      @sendAction('emptyComponent')
  ).on('init')

  description: Ember.computed 'concept', 'model.properties.name', ->
    description = @get("concept.#{@get('model.properties.name')}")
    if Ember.isEmpty description then return ""
    innerBullet = @get 'bulletClass'
    listingClass= @get 'listingClass'

    ender = @findEnder(description)
    @set 'ender', ender

    input = "<span>"+description;

    # known headers
    input = @processList(input, "Tasks include -","</span><h4>Tasks include:</h4>", "flatlist")

    input = @removeList(input,"Examples of the occupations classified here:")

    input = @removeList(input,"Some related occupations classified elsewhere:","</span><h4>Some related occupations classified elsewhere:</h4><span class=\""+listingClass+"\">")
    input = @removeList(input,"Occupations in this minor group are classified into the following unit group:")
    input = @removeList(input,"Occupations in this sub-major group are classified into the following minor group:")
    input = @removeList(input,"Occupations in this sub-major group are classified into the following unit group:")
    input = @removeList(input,"Occupations in this major group are classified into the following sub-major groups:")
    input = @removeList(input,"Occupations in this sub-major group are classified into the following minor groups:")
    input = @removeList(input,"Occupations in this minor group are classified into the following unit groups:")

    input = @replace(input,"Excluded from this group are:","</span><h4>Excluded from this group are:</h4><span class=\""+listingClass+"\">", true)

    # known list structures
    input = @replace(input, "\n (","</span><span class=\""+innerBullet+"\">(")
    input = @replace(input, ">-","><span class=\""+innerBullet+"\">-")
    input = @replace(input,"\n  -","</span><span class=\""+innerBullet+"\">-")
    #input = input.split(" -  ").join("</span><span class=\""+innerBullet+"\">-")

    input = @replace(input,"Notes\n","</span><h4>Notes</h4><span>")
    input = @replace(input,"Note\n","</span><h4>Note</h4><span>")

    input = input+"</span>"

  replace: (input, from, to, removeFirst) ->
    split = input.split(from)
    if removeFirst and split[1]
      split[1]=split[1].substring(1).trim()
    split.join(to)

  removeList: (input, headingText) ->
    split = input.split(headingText)
    if split[1]
      secondSplit = split[1].split(@get('ender'))
      target = split[1]

      if secondSplit[1]
        target = @get('ender')+secondSplit[1]
      else
        target = ""
      split[1] = target

    split.join("")

  findEnder: (description) ->
    enders = ["Excluded from this group","Note\n", "Notes\n"]
    found = null
    enders.map (ender) ->
      if (not found) and (description.indexOf(ender) >=0)
        found = ender
    found

  processList: (input, headingText, replacer, className) ->
    if not replacer
      replacer = headingText
    innerBullet = className or @get 'inlineListClass'
    split = input.split(headingText)
    if split[1]
      secondSplit = split[1].split(@get('ender'))
      target = split[1]
      if secondSplit[1]
        target=secondSplit[0]

      list = target.split("\n").map( (string) ->
        string?.trim()
      )
      # get the empty spans out
      list = list.filter (item) ->
        item.trim().length != 0

      target = list.join("</span><span>")

      if secondSplit[1]
        secondSplit[0]=target
        target = secondSplit.join("</span>#{@get('ender')}")
      split[1] = target

    split.join("</span><h4>#{replacer}</h4><span class=\""+innerBullet+"\"><span>")

`export default FormattedDescriptionComponent`

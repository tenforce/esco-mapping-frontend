`import Ember from 'ember'`
`import ENV from '../config/environment'`

MappingDashboardComponent = Ember.Component.extend
  mappingEffort: Ember.inject.service()
  effort: Ember.computed.alias 'mappingEffort.effort'
  taxfrom: Ember.computed.alias 'mappingEffort.from'
  taxto: Ember.computed.alias 'mappingEffort.to'

  toCompleteFilter: ENV.filters.toReview
  toApproveFilter: ENV.filters.toApprove
  toMapFilter: ENV.filters.toMap

  totalConceptsFrom: undefined,
  totalConceptsTo: undefined,
  totalMappableConceptsFrom: undefined,
  totalMappableConceptsTo: undefined,
  approvedConceptsFrom: undefined,
  approvedConceptsTo: undefined,
  approvedMappingsFrom: undefined,
  approvedMappingsTo: undefined,
  totalMappingsFrom: undefined,
  totalMappingsTo: undefined,
  mappedConceptsFrom: undefined,
  mappedConceptsTo: undefined,
  exactConceptsFrom: undefined,
  exactConceptsTo: undefined

  completedLeftLabel: Ember.computed 'taxfrom.preflabel', ->
    "Completed concepts in #{@get('taxfrom.preflabel')}"
  completedRightLabel: Ember.computed 'taxto.preflabel', ->
    "Completed concepts in #{@get('taxto.preflabel')}"
  mappedLeftLabel: Ember.computed 'taxfrom.preflabel', ->
    "Mapped concepts in #{@get('taxfrom.preflabel')}"
  mappedRightLabel: Ember.computed 'taxto.preflabel', ->
    "Mapped concepts in #{@get('taxto.preflabel')}"
  exactLeftLabel: Ember.computed 'taxfrom.preflabel', ->
    "Concepts with more than one exact match in #{@get('taxfrom.preflabel')}"
  exactRightLabel: Ember.computed 'taxto.preflabel', ->
    "Concepts with more than one exact match in #{@get('taxto.preflabel')}"
  init:(params) ->
    this._super(params)
    @totalConceptsFrom = @get('pTotalConceptsCountFrom')
    @totalConceptsTo = @get('pTotalConceptsCountTo')
    @totalMappableConceptsFrom = @get('pTotalMappableConceptsCountFrom')
    @totalMappableConceptsTo = @get('pTotalMappableConceptsCountTo')
    @approvedConceptsFrom = @get('pApprovedConceptsCountFrom')
    @approvedConceptsTo = @get('pApprovedConceptsCountTo')
    @approvedMappingsFrom = @get('pApprovedMappingsCountFrom')
    @approvedMappingsTo = @get('pApprovedMappingsCountTo')
    @totalMappingsFrom = @get('pTotalMappingsCountFrom')
    @totalMappingsTo = @get('pTotalMappingsCountTo')
    @mappedConceptsFrom = @get('pMappedConceptsCountFrom')
    @mappedConceptsTo = @get('pMappedConceptsCountTo')
    @exactConceptsFrom = @get('pExactConceptsCountFrom')
    @exactConceptsTo = @get('pExactConceptsCountTo')




## <--Mappings Approval--> ##

  pTotalMappingsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/09279ee0-ebb6-40b5-b777-3bb0650cb6f4/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pTotalMappingsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/09279ee0-ebb6-40b5-b777-3bb0650cb6f4/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##


## <--Mappings Approval--> ##

  pApprovedMappingsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/87b7cfba-9ef2-4ca5-9ee8-a717be514573/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
        "kpi-status": "approved"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pApprovedMappingsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/87b7cfba-9ef2-4ca5-9ee8-a717be514573/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
        "kpi-status": "approved"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##



## <--Concepts Approval--> ##

  pApprovedConceptsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/74328a44-d2c8-4d36-a300-e72bb1d6cde6/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
        "kpi-direction": "taxonomyFrom"
        "kpi-status": "Approved"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pApprovedConceptsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/74328a44-d2c8-4d36-a300-e72bb1d6cde6/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
        "kpi-direction": "taxonomyTo"
        "kpi-status": "Approved"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##




## <--Total Concepts--> ##
  pTotalConceptsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/36504aa4-c2b2-4b1b-b99d-3563f0b61590/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-taxonomySource": @get 'taxfrom.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pTotalConceptsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/36504aa4-c2b2-4b1b-b99d-3563f0b61590/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-taxonomySource": @get 'taxto.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##

  pTotalMappableConceptsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/c72b89ca-ca30-46c5-b191-0c7bf62d3d0d/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-taxonomySource": @get 'taxto.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
  pTotalMappableConceptsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/c72b89ca-ca30-46c5-b191-0c7bf62d3d0d/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-taxonomySource": @get 'taxfrom.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##

## <-Mapped concepts-> ##
  pMappedConceptsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/e9f1cc43-5a4e-43b3-a41e-3f369182a140/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-direction": "mapsFrom"
        "kpi-mappingEffort": @get 'effort.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pMappedConceptsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/e9f1cc43-5a4e-43b3-a41e-3f369182a140/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-direction": "mapsTo"
        "kpi-mappingEffort": @get 'effort.id'
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##

## <-Exact concepts-> ##
  pExactConceptsCountFrom: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/d2a62660-2168-4ad6-b223-bd430d76ad7d/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-direction": "mapsFrom"
        "kpi-mappingEffort": @get "effort.id"
        "kpi-matchType": "exact"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })


  pExactConceptsCountTo: Ember.computed "effort.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/d2a62660-2168-4ad6-b223-bd430d76ad7d/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-direction": "mapsTo"
        "kpi-mappingEffort": @get "effort.id"
        "kpi-matchType": "exact"
      },
      success: (response) =>
        resolve(response.data.attributes.total)
      error: (error) =>
        resolve(0)
    })
## <------------> ##


`export default MappingDashboardComponent`

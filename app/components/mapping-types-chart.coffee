`import Ember from 'ember'`

MappingTypesChartComponent = Ember.Component.extend

  pieChartData: Ember.computed 'pCountMappingStatus', 'taxonomy.preflabel', -> new Ember.RSVP.Promise (resolve) =>
    @get('pCountMappingStatus').then (params) =>
      label = @get 'taxonomy.preflabel'
      t=[]
      bExact = false
      bBroad = false
      bNarrow = false
      bClose = false
      if params.data
        for obs in params.data
          if(obs.attributes && obs.attributes.matchType == "exact")
            bExact = true
            t.push({
              label: "Match"
              value: obs.attributes.total
              color: "#048CC8"
              highlight: "lightblue"
              sort: "1"
            })
          if(obs.attributes && obs.attributes.matchType == "broad")
            bBroad = true
            t.push({
              label: "More specific than #{label}"
              value: obs.attributes.total
              color: "#42BA1D"
              highlight: "lightgreen"
              sort: "2"
            })
          if(obs.attributes && obs.attributes.matchType == "narrow")
            bNarrow = true
            t.push({
              label: "More general than #{label}"
              value: obs.attributes.total
              color: "#CE4233"
              highlight: "pink"
              sort: "3"
            })
          # if(obs.attributes && obs.attributes.matchType == "close")
          #   bClose = true
          #   t.push({
          #     label: "Close match"
          #     value: obs.attributes.total
          #     color: "#E6D501"
          #     highlight: "yellow"
          #     sort: "4"
          #   })

      if(!bExact)
        t.push({
          label: "Match"
          value: 0
          color: "#048CC8"
          highlight: "lightblue"
          sort: "1"
        })
      if(!bBroad)
        t.push({
          label: "More specific than #{label}"
          value: 0
          color: "#42BA1D"
          highlight: "lightgreen"
          sort: "2"
        })
      if(!bNarrow)
        t.push({
          label: "More general than #{label}"
          value: 0
          color: "#CE4233"
          highlight: "pink"
          sort: "3"
        })
      # if(!bClose)
      #   t.push({
      #     label: "Close match"
      #     value: 0
      #     color: "#E6D501"
      #     highlight: "yellow"
      #     sort: "4"
      #   })
      t = t.sortBy('sort')
      resolve(t)
  chartOptions:
    segmentShowStroke : false,
    segmentStrokeColor : "#fff",
    segmentStrokeWidth : 0,
    percentageInnerCutout : 0,
    animationSteps : 100,
    animationEasing : "easeOutCubic",
    animateRotate : true,
    animateScale : false,
    showTooltips: false


  pCountMappingStatus: Ember.computed "taxonomy.id",  "compared.id", -> new Ember.RSVP.Promise (resolve) =>
    Ember.$.ajax({
      url: "/kpis/85aa77f0-f0ad-4cb9-8801-fca9945908aa/run",
      crossDomain: true,
      type: "GET",
      data:{
        "kpi-mappingEffort": @get 'effort.id'
      },
      success: (response) =>
        resolve(response.data.relationships.observations)
      error: (error) =>
        resolve({})
    })
`export default MappingTypesChartComponent`

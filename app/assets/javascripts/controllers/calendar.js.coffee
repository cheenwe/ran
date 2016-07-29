
((window, document, $) ->

  initCalendar = (calElement, events) ->
    removeAfterDrop = $('#remove-after-drop')
    calElement.fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay'
      buttonIcons:
        prev: ' fa fa-caret-left'
        next: ' fa fa-caret-right'
      buttonText:
        today: 'today'
        month: 'month'
        week: 'week'
        day: 'day'
      editable: true
      droppable: true

      eventDragStart: (event, js, ui) ->
        draggingEvent = event
        return
      events: events
    return


  createDemoEvents = ->
    date = new Date
    d = date.getDate()
    m = date.getMonth()
    y = date.getFullYear()
    [ {
      title: 'Open Google'
      start: new Date
      url: '/api/v1/schedule?play_date={{start}}'
      backgroundColor: '#3c8dbc'
      borderColor: '#3c8dbc'
    } ]

  if !$.fn.fullCalendar
    return
  $ ->
    calendar = $('#calendar')
    demoEvents = createDemoEvents()
    initCalendar calendar, demoEvents
    return
  draggingEvent = null

  ExternalEvent = (elements) ->
    if !elements
      return
    elements.each ->
      $this = $(this)
      calendarEventObject = title: $.trim($this.text())
      $this.data 'calendarEventObject', calendarEventObject
      $this.draggable
        zIndex: 1070
        revert: true
        revertDuration: 0
      return
    return

  return
) window, document, window.jQuery


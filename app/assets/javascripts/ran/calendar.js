// Custom jQuery
// -----------------------------------


(function(window, document, $, undefined){

  if(!$.fn.fullCalendar) return;

  // When dom ready, init calendar and events
  $(function() {

      // The element that will display the calendar
      var calendar = $('#calendar');

      var demoEvents = createDemoEvents();


      initCalendar(calendar, demoEvents);

  });


  // global shared var to know what we are dragging
  var draggingEvent = null;

  /**
   * ExternalEvent object
   * @param jQuery Object elements Set of element as jQuery objects
   */
  var ExternalEvent = function (elements) {

      if (!elements) return;

      elements.each(function() {
          var $this = $(this);
          // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
          // it doesn't need to have a start or end
          var calendarEventObject = {
              title: $.trim($this.text()) // use the element's text as the event title
          };

          // store the Event Object in the DOM element so we can get to it later
          $this.data('calendarEventObject', calendarEventObject);

          // make the event draggable using jQuery UI
          $this.draggable({
              zIndex: 1070,
              revert: true, // will cause the event to go back to its
              revertDuration: 0  //  original position after the drag
          });

      });
  };

  /**
   * Invoke full calendar plugin and attach behavior
   * @param  jQuery [calElement] The calendar dom element wrapped into jQuery
   * @param  EventObject [events] An object with the event list to load when the calendar displays
   */
  function initCalendar(calElement, events) {

      // check to remove elements from the list
      var removeAfterDrop = $('#remove-after-drop');

      calElement.fullCalendar({
          // isRTL: true,
          header: {
              left:   'prev,next today',
              center: 'title',
              right:  'month,agendaWeek,agendaDay'
          },
          buttonIcons: { // note the space at the beginning
              prev:    ' fa fa-caret-left',
              next:    ' fa fa-caret-right'
          },
          buttonText: {
              today: 'today',
              month: 'month',
              week:  'week',
              day:   'day'
          },
          editable: true,
          droppable: true, // this allows things to be dropped onto the calendar
          drop: function(date, allDay) { // this function is called when something is dropped

              var $this = $(this),
                  // retrieve the dropped element's stored Event Object
                  originalEventObject = $this.data('calendarEventObject');

              // if something went wrong, abort
              if(!originalEventObject) return;

              // clone the object to avoid multiple events with reference to the same object
              var clonedEventObject = $.extend({}, originalEventObject);

              // assign the reported date
              clonedEventObject.start = date;
              clonedEventObject.allDay = allDay;
              clonedEventObject.backgroundColor = $this.css('background-color');
              clonedEventObject.borderColor = $this.css('border-color');

              // render the event on the calendar
              // the last `true` argument determines if the event "sticks"
              // (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
              calElement.fullCalendar('renderEvent', clonedEventObject, true);

              // if necessary remove the element from the list
              if(removeAfterDrop.is(':checked')) {
                $this.remove();
              }
          },
          eventDragStart: function (event, js, ui) {
            draggingEvent = event;
          },
          // This array is the events sources
          events: events
      });
  }


  /**
   * Creates an array of events to display in the first load of the calendar
   * Wrap into this function a request to a source to get via ajax the stored events
   * @return Array The array with the events
   */
  function createDemoEvents() {
    // Date for the calendar events (dummy data)
    var date = new Date();
    var d = date.getDate(),
        m = date.getMonth(),
        y = date.getFullYear();

    return  [
              {
                  title: 'Open Google',
                  start: new Date(),
                  url: '/api/v1/schedule?play_date={{start}}',
                  backgroundColor: '#3c8dbc', //Primary (light-blue)
                  borderColor: '#3c8dbc' //Primary (light-blue)
              }
          ];
  }

})(window, document, window.jQuery);





(function(window, document, $, undefined){

  if (typeof $ === 'undefined') { throw new Error('This application\'s JavaScript requires jQuery'); }

  $(function(){

    var $body = $('body');
    new StateToggler().restoreState( $body );

    $('#chk-fixed').prop('checked', $body.hasClass('layout-fixed') );
    $('#chk-collapsed').prop('checked', $body.hasClass('aside-collapsed') );
    // $('#chk-boxed').prop('checked', $body.hasClass('layout-boxed') );
    // $('#chk-float').prop('checked', $body.hasClass('aside-float') );
    // $('#chk-hover').prop('checked', $body.hasClass('aside-hover') );

    // POPOVER
    // -----------------------------------

    $('[data-toggle="popover"]').popover();

    // TOOLTIP
    // -----------------------------------

    $('[data-toggle="tooltip"]').tooltip({
      container: 'body'
    });

    // DROPDOWN INPUTS
    // -----------------------------------
    $('.dropdown input').on('click focus', function(event){
      event.stopPropagation();
    });


  });


})(window, document, window.jQuery);

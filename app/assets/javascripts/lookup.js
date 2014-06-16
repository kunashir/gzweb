var lookupHandlers;

function LookupHandlers() {
  var select_handlers = [];

  this.select = function ( callback ) {
    select_handlers[select_handlers.length] = callback;
  }

  this.onSelect = function (element) {
    for (var i in select_handlers)
      select_handlers[i](element);
  }
}

(function( $ ) {
    $.widget( "custom.lookup", {
      _create: function() {
        this.lookup = this.element.data("lookup");
        this.lookupTerm = this.element.data("lookup-term") || "term";
        this.dataType = this.element.data("lookup-datatype") || "json";

        this.wrapper = $("<div>")
          .addClass("lookup-container")
          .appendTo(this.element[0].parentElement);

        this.element
          .appendTo(this.wrapper);

        this._createAutocomplete();
        this._createButtons();
      },
 
      _createAutocomplete: function() {
        this.element
          .autocomplete({
            delay: 0,
            minLength: 1,
            source: $.proxy( this, "_source" ),
            focus: $.proxy( this, "_focus" ),
            select: $.proxy( this, "_select" ),
            change: $.proxy( this, "_change" )
          })
          .tooltip({
            tooltipClass: "ui-state-highlight"
          });
      },
 
      _createButtons: function() {
        var input = this.element, wasOpen = false;

        var actionArea = $("<div>")
          .addClass("edit-actions")
          .appendTo(this.wrapper)

        $( "<a>" )
          .attr( "tabIndex", -1 )
          .tooltip()
          .appendTo( actionArea )
          .button({
            icons: {
              primary: "ui-icon-triangle-1-s"
            },
            text: false
          })
          .removeClass( "ui-corner-all" )
          .addClass( "custom-combobox-toggle" )
          .mousedown(function() {
            wasOpen = input.autocomplete( "widget" ).is( ":visible" );
          })
          .click(function() {
            input.focus();
            // Close if already visible
            if ( wasOpen ) {
              return;
            }
            // Pass empty string as value to search for, displaying all results
            input.autocomplete( "search", "_" );
          });

        $( "<a>" )
          .attr( "tabIndex", -1 )
          .tooltip()
          .appendTo( actionArea )
          .button({
            icons: {
              primary: "ui-icon-close"
            },
            text: false
          })
          .removeClass( "ui-corner-all" )
          .addClass( "custom-combobox-toggle" )
          .mousedown(function() {
            wasOpen = input.autocomplete( "widget" ).is( ":visible" );
          })
          .click(function() {
            input.focus();
            input.val("");
            input.data( "id", "" );
            input.data( "text", "" );
            lookupHandlers.onSelect(input[0]);
          });
      },

      _source: function( request, response ) {
        var data = {}
        data[this.lookupTerm] = request.term
        $.ajax({
          url: this.lookup,
          dataType: this.dataType,
          data: data,
          success: function( data ) {
            response( $.map( data.employees, function( item ) {
              return {
                label: item.name,
                value: item
              }
            }));
          }
        });
      },

      _focus: function( event, ui) {
        event.preventDefault();
      },

      _select: function( event, ui) {
        event.preventDefault();
        this.element.val( ui.item.value.name );
        this.element.data( "id", ui.item.value.id );
        this.element.data( "text", ui.item.value.name );
        lookupHandlers.onSelect(this.element[0]);
      },

      _change: function (event, ui) {
        if (this.element.val() == '')
        {
          this.element.data("text", "");
          this.element.data("id", "");
        }
        else
          this.element.val(this.element.data("text"));
      },
 
      _destroy: function() {}
    });
  })( jQuery );

$(initLookups);

function initLookups() {
  lookupHandlers = new LookupHandlers();
  $(".edit-lookup").lookup();
}

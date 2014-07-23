function MultiLookupToken(options) {
  var _this = this;
  var removed_handlers = [];

  this.$ = jQuery;
  this.options = $.extend({ id: null, name: ""}, options || {})
  this.token = $("<div>").addClass("token"),
  this.label = $("<span>").addClass("token-label"),
  this.close = $("<a>").addClass("close").attr("tabindex", "-1").html("&times;");
  this.text = options['name'];
  this.id = options['id'];
  this.isSelected = false;

  this.token.append(this.label).append(this.close);
  this.label.text(options['name']);

  this.close.click(function (e) {
    e.preventDefault();
    _this.remove();
  });

  this.insertBefore = function (element) {
    _this.$(element).before(_this.token);
    return _this;
  }

  this.removed = function (handler) {
    if (handler)
      removed_handlers.push(handler);
    else
      removed_handlers.forEach(function (handler) {
        handler(_this);
      });
    return _this;
  }

  this.remove = function () {
    _this.token.remove();
    _this.removed();
  }

  this.select = function () {
    if (!_this.isSelected) {
      _this.isSelected = true;
      _this.token.addClass('selected');
    }
  }

  this.deselect = function () {
    if (_this.isSelected) {
      _this.isSelected = false;
      _this.token.removeClass('selected');
    }
  }
}

(function( $ ) {
    $.widget( "custom.lookupMulti", {
      _create: function() {
        var _self = this;
        this.lookup = this.element.data("lookup");
        this.lookupTerm = this.element.data("lookup-term") || "term";
        this.dataType = this.element.data("lookup-datatype") || "json";
        this.singleSelect = this.element.data("lookup-single") || false;

        this.element
           .css('position', 'absolute')
           .css('left', '-10000px')
           .prop('tabindex', -1);

        this.wrapper = $("<div>")
          .addClass("form-edit-control")
          .addClass("lookup-container")
          .mousedown(function (e) { 
            setTimeout(function () { _self.input.focus(); }, 1);
          });

        $(window).resize(function () {
          if (_self.input.is(document.activeElement))
            _self._updateSize();
          else
            _self._updateSizeBlur();
        })

        this.input = $("<input>")
          .addClass("inline-edit-control")
          .appendTo(this.wrapper)
          .focus($.proxy(this, "_inputFocus"))
          .blur($.proxy(this, "_inputBlur"))
          .keydown($.proxy(this, "_inputKeyDown"));

        this.wrapper.insertBefore(this.element);
        this.element.prependTo(this.wrapper);
        this.tokens = [];
        this.selectedToken = null;
        this.selection = null;
        this.focusHandlers = [];
        this.blurHandlers = [];
        this.changeHandlers = [];
        this.ignoreNextBlur = false;

        this._createAutocomplete();
      },

      widget: function () {
        var self = this;
        return function () { return self; }
      },
 
      _createAutocomplete: function() {
        this.input
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

      focus: function(handler) {
        if (handler instanceof Function)
          this.focusHandlers.push(handler);
        else
          this.input.focus();
      },

      blur: function(handler) {
        if (handler instanceof Function)
          this.blurHandlers.push(handler);
      },

      _inputFocus: function() {
        this._updateSize();
        var self = this;
        this.focusHandlers.forEach(function (handler) { handler(self); });
      },

      _updateSize: function() {
        this._updateSizeBlur();
        var inputMarginLeft = parseInt(this.input.css('margin-left'), 10),
            inputMarginRight = parseInt(this.input.css('margin-right'), 10),
            inputMargin = inputMarginLeft + inputMarginRight;
        var width = this.wrapper.width() + this.wrapper.offset().left - this.input.offset().left - inputMargin - 6;
        if (width < 180)
          width = this.wrapper.width() - inputMargin - 16;
        this.input.width(width + "px");
      },

      _inputBlur: function(e) {
        if (this.ignoreNextBlur)
        {
          e.preventDefault();
          this.input.focus();
          this.ignoreNextBlur = false;
          return;
        }
        this._updateSizeBlur();
        var self = this;
        this.blurHandlers.forEach(function (handler) { handler(self); });
        this._setSelectedToken(null);
      },

      preventFocusLoss: function() {
        this.ignoreNextBlur = true;
      },

      _updateSizeBlur: function() {
        this.input.width('0px');
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
        this.addToken(ui.item.value);
      },

      addToken: function (item) {
        var self = this;

        token = new MultiLookupToken(item)
                  .insertBefore(this.input)
                  .removed(function (token) { self.tokens.remove(token); self._updateValue(); });
        if (this.singleSelect)
          this.reset();
        else
          this.removeToken(item);

        this.tokens.push(token);
        this._updateValue();

        this.input.val("");
        this._updateSize();
      },

      removeToken: function (item) {
        this.tokens.
          filter(function (token) { return token.id == item.id }).
          clone().
          forEach(function (token) { token.remove(); });

        this._updateSize();
      },

      reset: function () {
        this.tokens.
          clone().
          forEach(function (token) { token.remove(); });

        this._updateSize();
      },

      _inputKeyDown: function (e) {
        switch(e.keyCode) {
          case 8: // backspace
            if (this.input.is(document.activeElement) && this.input.val() == "") {
              if (!this.tokens.isEmpty()) {
                if (this.selectedToken) {
                  this.selectedToken.remove();
                  this._updateSize();
                }
                this._setSelectedToken(this.tokens.last());
              }
            }
            break;
          case 46: // delete
            if (this.selectedToken) {
              this.selectedToken.remove();
              this._setSelectedToken(null);
              this._updateSize();
            }
            break;
          default:
            this._setSelectedToken(null);
            break;
        }
      },

      _setSelectedToken: function (token) {
        if (this.selectedToken)
          this.selectedToken.deselect();
        this.selectedToken = token;
        if (this.selectedToken)
          this.selectedToken.select();
      },

      _updateValue: function () {
        this.selection = this.tokens.map(function (item) { return { id: item.id, text: item.text }});
        this._onChange();
      },

      change: function (handler) {
        if (handler instanceof Function)
          this.changeHandlers.push (handler);
      },

      _onChange: function () {
        var self = this;
        this.changeHandlers.forEach(function (handler) { handler(self); })
      },

      _change: function (event, ui) {
        if (this.input.val() == '')
        {
          this.input.data("text", "");
          this.input.data("id", "");
        }
        else
          this.input.val(this.input.data("text"));
      },
 
      _destroy: function() {}
    });
  })( jQuery );

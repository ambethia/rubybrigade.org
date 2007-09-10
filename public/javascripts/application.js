// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// Takes a label and puts it into a textfield to act like a label.  When the user brings focus to the form element, the label disappears.  Also, when the form is submitted, the inputs are cleared of their contents of their label
var LabelInInput = Class.create();
LabelInInput.prototype = {
  initialize: function() {
    if ($("search-label")) {
      this.element = $("search-label");
      this.formElement = $("search");
      this.formElement.observe('focus', this.removeLabel.bindAsEventListener(this));
      this.formElement.observe('blur', this.addLabel.bindAsEventListener(this));
      this.element.up('form').observe('submit', this.removeLabel.bindAsEventListener(this));
      this.addLabel();
      
    };
  },
  addLabel: function(e) {
    if(this.formElement.value == "" || this.formElement.value == this.element.innerHTML) {
      this.formElement.addClassName('inactive');
      this.formElement.value = this.element.innerHTML;
    }
  },
  removeLabel: function(e) {
    if(this.formElement.hasClassName('inactive')) {
      this.formElement.removeClassName('inactive');
      this.formElement.value = "";
    }
  }
};

new LabelInInput;

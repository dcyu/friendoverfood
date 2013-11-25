// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){


  // Clear the console
  console.clear();
   
  // Plugin
  (function ($) {
  $.fn.antispam = function () {
  return this.each(function () {
  var $self = $(this);
  // Get the text
  var text = $self.text();
  // Replace "at" and "dot"
  var email = text.replace(" at ", "@").replace(" dot ", ".");
  // Create a link
  var $link = $("<a></a>");
  $link.attr("href", "mailto:" + email);
  $link.text(email);
  // Replace the span with the link
  $self.html( $link );
  });
  };
  })(jQuery);
   
  $(".antispam").antispam();

});
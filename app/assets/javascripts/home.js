// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).on('turbolinks:load', function() {
  $('body').fadeIn(2000);
  $('#flash-msg').fadeIn(3000);
  $('#flash-msg').fadeOut(8000);
});
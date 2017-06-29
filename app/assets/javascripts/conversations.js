// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function handleKeyCode(e) {
  if (e.keyCode === 13) {
    e.preventDefault();
    var values = $(e.target.parentElement).serializeArray();
    if (values[1].value !== "") {
      App.conversation.speak(values);
    }
    $(e.target.parentElement).trigger('reset');
  }
}

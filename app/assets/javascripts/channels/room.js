App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
      console.log(data.pot);
      $('#pot').html(data.pot);
      if (data.not_turn == true) {
        console.log('hiding!');
        $('.wait').css('visibility', 'visible');
      } else if (data.turn == true) {
        console.log('revealing!');
        $('.wait').css('visibility', 'hidden');
      } else if (data.call == true) {
        $('.wait').css('visibility', 'visible');
        $.ajax({
          url: "/flop"
        });
      } 
  }
});

//   $('#messages-table').append('<div class="message">' +
//     '<div class="message-user">' + data.username + ':' + '</div>' +
//     '<div class="message-user">' + data.content + '</div>');
// }
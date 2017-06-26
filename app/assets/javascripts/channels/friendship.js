App.friendship = App.cable.subscriptions.create("FriendshipChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log(data['message']);
  },

  sent: function() {
    return this.perform('sent');
  }
});

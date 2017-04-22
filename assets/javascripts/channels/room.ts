import * as ActionCable from 'actioncable';
function handleRoom(app: ActionCable.AppInterface){
    app.room = app.cable.subscriptions.create("RoomChannel", {
        connected: function() {
            // Called when the subscription is ready for use on the server
        },

        disconnected: function() {
            // Called when the subscription has been terminated by the server
        },

        received: function(data) {
            // Called when there's incoming data on the websocket for this channel
        },

        say: function() {
            return this.perform('say');
        }
    });
}

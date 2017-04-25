import * as ActionCable from 'actioncable';
function handleChat(app: AppInterface) {
    (app as any).room = app.cable.subscriptions.create('ChatChannel', {
        connected: () => {
            // Called when the subscription is ready for use on the server
            console.log("chatChannel connected.");
        },

        disconnected: () => {
            // Called when the subscription has been terminated by the server
            console.log("chatChannel disconnected.");
        },

        received: (data) => {
            // Called when there's incoming data on the websocket for this channel
            console.log("chat message received:");
            console.log(data);
        },
    });
}

export = handleChat;

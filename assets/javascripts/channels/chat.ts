import * as Vue from 'vue';
import * as ActionCable from 'actioncable';

function createChatChannel(cable: ActionCable.Cable, eventBus: Vue) {
    return cable.subscriptions.create('ChatChannel', {
        connected() {
            // Called when the subscription is ready for use on the server
            console.log("chatChannel connected.");
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
            console.log("chatChannel disconnected.");
        },

        received(data) {
            // Called when there's incoming data on the websocket for this channel
            console.log("chat message received:");
            console.log(data);
            console.log(eventBus);
            eventBus.$emit('messageReceived', ( data as any ).room, data);
        },

        subscribe(access_token, rooms) {
            this.perform('subscribe', {
                access_token: access_token,
                rooms: rooms,
            });
        },
    });
};

export default createChatChannel;
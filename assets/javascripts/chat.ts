import * as ActionCable from 'actioncable';
import axios, { AxiosPromise, AxiosRequestConfig } from 'axios';
import * as moment from 'moment';
import * as Vue from 'vue';
import * as model from './model/';
import createChatChannel from './channels/chat.ts';
import AppConfig from './config.ts';
declare function require(name: string);
const messagesView = require('./view/messages.vue');
const messageInputView = require('./view/message-input.vue');
const roomsView = require('./view/rooms.vue');
const roomMenuView = require('./view/room-menu.vue');

// Initialize global context

const App = {
    cable: ActionCable.createConsumer(),
    chat: {},
    config: new AppConfig(),
};

class ApiClient {
    constructor(public baseUrl: string) {}

    public messages() {
        return new Promise((resolve, reject) => {
            return resolve([
                {
                    speaker: {
                        id: 'user-id',
                        name: 'speaker name',
                    },
                    avatar_thumbnail_url: '',
                    // ISO8601
                    posted_at: moment().format(),
                    text: 'hi',
                },
            ]);
        });
    }
}

class Chat {
    accessToken: string;

    constructor(accessToken: string) {
        this.accessToken = accessToken;
    }

    start(): void {
        // automatically insert some headers for all requests
        (Vue.prototype as any).$http = axios.create({
            xsrfHeaderName: 'X-CSRF-Token',
            withCredentials: true,
            baseURL: '/api',
            headers: {
                'X-Access-Token': this.accessToken,
            },
        });
        // can access global configuration
        (Vue.prototype as any).$config = App.config;

        const MessagesView = Vue.extend(messagesView);
        const MessageInputView = Vue.extend(messageInputView);
        const RoomsView = Vue.extend(roomsView);
        const RoomMenuView = Vue.extend(roomMenuView);

        const eventBus = new Vue();
        // Add chat channel
        App.chat = createChatChannel(App.cable, eventBus);
        eventBus.$on('subscribeRoom', (room) => {
            const screenNames = [room.screen_name];
            ( App.chat as any ).subscribe(this.accessToken, screenNames);
        });
        // Play sound when received a message
        eventBus.$on('messageReceived', (room, message) => {
            App.config.isSoundEnabled().then((enabled: boolean) => {
                if(enabled) {
                    const ring = document.body.querySelector('audio.ring') as HTMLAudioElement;
                    ring.play();
                }
            });
        });
        // store latest choosen room
        eventBus.$on('changeRoom', room => App.config.setActiveRoom(room));

        new RoomsView({
            el: '#chatapp .sidebar',
            propsData: {
                eventBus,
            },
        });
        new RoomMenuView({
            el: '#chatapp .room-menu',
            propsData: {
                eventBus,
            },
        });
        new MessageInputView({
            el: '#say_text',
            propsData: {
                eventBus,
            },
        });
        new MessagesView({
            el: '#chatapp .talks',
            propsData: {
                eventBus,
            },
        });
        new MessageInputView({
            el: '#say_text',
            propsData: {
                eventBus,
            },
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    // get access token via DOM
    const accessToken = document.head.querySelector('meta[name="access-token"]').getAttribute('content');
    new Chat(accessToken).start();
});

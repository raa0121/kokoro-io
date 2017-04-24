import * as ActionCable from 'actioncable';
import axios, { AxiosPromise, AxiosRequestConfig } from 'axios';
import * as moment from 'moment';
import * as Vue from 'vue';
import * as model from './model/';
declare function require(name: string);
// const roomChannel= require('./channels/room.ts');
const messagesView = require('./view/messages.vue');
const messageInputView = require('./view/message-input.vue');
const roomsView = require('./view/rooms.vue');

// Initialize global context
const App = {
    cable: ActionCable.createConsumer(),
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

document.addEventListener('DOMContentLoaded', () => {
    // get access token via DOM
    const accessToken = document.head.querySelector('meta[name="access-token"]').getAttribute('content');
    // automatically insert some headers for all requests
    (Vue.prototype as any).$http = axios.create({
        xsrfHeaderName: 'X-CSRF-Token',
        withCredentials: true,
        baseURL: '/api',
        headers: {
            'X-Access-Token': accessToken,
        },
    });

    const MessagesView = Vue.extend(messagesView);
    const MessageInputView = Vue.extend(messageInputView);
    const RoomsView = Vue.extend(roomsView);

    const eventBus = new Vue();
    new RoomsView({
        el: '#chatapp .sidebar',
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
});

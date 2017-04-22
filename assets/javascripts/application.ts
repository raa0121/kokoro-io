import * as Vue from 'vue';
import * as moment from 'moment';
import axios, { AxiosRequestConfig, AxiosPromise } from 'axios';
import * as ActionCable from 'actioncable';
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

class ApiClient
{
    constructor(public baseUrl: string){}

    public messages()
    {
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

const data= {
    messages: [
        {
            speaker: {
                id: 'user-id',
                name: 'speaker name',
            },
            avatar_thumbnail_url: 'https://avatars.githubusercontent.com/u/377137?v=2&s=32',
            // ISO8601
            posted_at: moment().format(),
            text: 'hi',
        },
        {
            speaker: {
                id: 'user-id',
                name: 'speaker name',
            },
            avatar_thumbnail_url: 'https://avatars.githubusercontent.com/u/377137?v=2&s=32',
            // ISO8601
            posted_at: moment().format(),
            text: 'hi',
        },
    ],
};

document.addEventListener('DOMContentLoaded', () => {
    // get access token via DOM
    const accessToken = document.head.querySelector('meta[name="access-token"]').getAttribute('content');
    // automatically insert some headers for all requests
    (<any>Vue.prototype).$http = axios.create({
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
            eventBus: eventBus,
        },
    });
    new MessagesView({
        el: '#chatapp .talks',
        propsData: {
            eventBus: eventBus,
            messages: data.messages,
        },
    });
    new MessageInputView({
        el: '#say_text',
        propsData: {
            eventBus: eventBus,
        },
    });
});

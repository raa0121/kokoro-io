import * as Vue from 'vue';
import * as moment from 'moment';
import axios, { AxiosRequestConfig, AxiosPromise } from 'axios';
declare function require(name: string);
const messagesView= require('./view/messages.vue');
const messageInputView= require('./view/message-input.vue');

Vue.prototype.$http = axios.create({
    xsrfHeaderName: 'X-CSRF-Token',
    withCredentials: true,
    baseURL: '/api'
});

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
    const MessagesView= Vue.extend(messagesView);
    const MessageInputView= Vue.extend(messageInputView);

    new MessagesView({
        el: '#chatapp .talks',
        data: data,
    });
    new MessageInputView({
        el: '#say_text',
    });
});

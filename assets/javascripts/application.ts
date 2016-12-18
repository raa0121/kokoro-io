import * as Vue from 'vue';
declare function require(name: string);
const Application= require('./application.vue');

class Program
{
    name: string;

    constructor(public message: string){}

    exec()
    {
        console.log(this.message);
    }
}

var program= new Program('hello kokoro.io');

program.exec();

document.addEventListener('DOMContentLoaded', () => {
    (<any>window).vue= new Vue({
        el: '#chatapp',
        data: {
            text: 'hi',
        },
        components: {
            'x-chat': Application,
        },
    });
});

<template>
    <textarea id="say_text" placeholder="Let's talk!" v-bind:rows="inputLines" v-bind:disabled="disabled" v-model="text" v-on:keypress="maybeSay($event)"></textarea>
</template>

<script>
    import moment from 'moment';
    import KeyCode from 'keycode-js';
    import * as model from '../model/';

    export default {
        props: {
            eventBus: {
                required: true,
            },
        },

        data(){
            return {
                suppressingInput: false,

                text: '',

                room: {},
            };
        },

        mounted(){
            this.eventBus.$on('changeRoom', room => this.room = room);
        },

        computed: {
            enabled(){
                if(this.suppressingInput)
                {
                    return false;
                }
                // enabled when any room selected
                return Object.keys(this.room).length > 0;
            },

            disabled(){
                return !this.enabled;
            },

            inputLines(){
                return this.text.split(/\r\n|\r|\n/).length + 1;
            },
        },

        methods: {
            maybeSay(evt){
                switch(evt.keyCode || evt.which)
                {
                    case KeyCode.KEY_ENTER:
                    case KeyCode.KEY_RETURN:
                        // Shift+Enter = New line
                        if(!!evt.shiftKey)
                        {
                            return true;
                        }
                        evt.preventDefault();

                        this.suppressingInput = true;
                        const allowInput = () => this.suppressingInput = false;

                        const room = JSON.parse(JSON.stringify(this.room));
                        const text = this.text;
                        const transitMessage = {
                            content: text,
                            room: JSON.parse(JSON.stringify(room)),
                            profile: {
                                type: 'user',
                                screen_name: "posting...",
                                display_name: "posting...",
                                avatar: '',
                            },
                            transitNumber: window.performance.now(),
                        };
                        const promise = this.$http.post(`/v1/rooms/${this.room.screen_name}/messages`, {
                            message: text,
                        });
                        promise.then(allowInput, allowInput);
                        promise.then((response) => {
                            this.text = '';
                            // commit transit message
                            this.$emit('removeTemporaryMessage', room, transitMessage, response.data);
                            this.eventBus.$emit('removeTemporaryMessage', room, transitMessage, response.data);
                        });
                        this.$emit('postingMessage', room, transitMessage);
                        this.eventBus.$emit('postingMessage', room, transitMessage);
                        return false;
                }
            },
        },
    };
</script>

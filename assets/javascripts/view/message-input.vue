<template>
    <textarea id="say_text" placeholder="Let's talk!" v-bind:disabled="disabled" v-model="text" v-on:keypress="maybeSay($event)"></textarea>
</template>

<script>
    import moment from 'moment';
    import KeyCode from 'keycode-js';

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

                        // TODO: Post message
                        this.suppressingInput = true;
                        const allowInput = () => this.suppressingInput = false;

                        const text = this.text;
                        const promise = this.$http.post(`/v1/rooms/${this.room.id}/messages`, text);
                        promise.then(allowInput, allowInput);
                        promise.then((response) => this.text = '');

                        const message = {
                            speaker: {
                                id: 'user-id',
                                name: 'speaker name',
                            },
                            avatar_thumbnail_url: 'https://avatars.githubusercontent.com/u/377137?v=2&s=32',
                            // ISO8601
                            posted_at: moment().format(),
                            text: text,
                        };
                        this.$emit('say', this.room, message);
                        this.eventBus.$emit('say', this.room, message);
                        return false;
                }
            },
        },
    };
</script>

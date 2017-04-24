<template>
    <div class="talks">
        <div class="talk" v-for="message in messages.items">
            <div class="avatar">
                <img v-bind:src="message.profile.avatar" alt="">
            </div>
            <div class="message">
                <div class="speaker">{{message.profile.display_name}}<small class="timeleft text-muted">{{message.published_at}}</small></div>
                <div class="filtered_text">{{message.content}}</div>
            </div>
        </div>
    </div>
</template>

<script lang="typescript">
    import moment from 'moment';

    export default {
        props: {
            eventBus: {
                required: true,
            },
        },

        data(){
            return {
                messages: {
                    room: {},

                    items: [],
                },

                // room.id => messages
                roomMessages: {},
            };
        },

        mounted(){
            this.eventBus.$on('postingMessage', (room, message) => {
                this.roomMessages[room.screen_name].items.push(message);
            });
            this.eventBus.$on('commitMessage', (room, removalMessage, commitedMessage) => {
                const messages = this.roomMessages[room.screen_name];
                messages.items = messages.items.filter(message => !!message.id);
                messages.items.push(commitedMessage);
            });
            this.eventBus.$on('changeRoom', this.changeRoom);
        },

        updated(){
            this.scrollToLatestTalk();
        },

        methods: {
            changeRoom(room){
                console.log('changeRoom', room);
                if(!this.roomMessages[room.screen_name])
                {
                    this.roomMessages[room.screen_name] = {
                        room: room,
                        items: [],
                    };
                }
                // set reference
                const messages = this.roomMessages[room.screen_name];
                this.messages = messages;

                // read initial data
                const promise = this.$http.get(`/v1/rooms/${room.screen_name}/messages`, {
                    params: {
                        limit: 30,
                        offset: 0,
                    },
                });
                promise.then(response => {
                    (response.data || []).forEach(message => messages.items.push(message));
                });
            },

            scrollToLatestTalk(){
                const talksPane = document.querySelector(".talks");
                talksPane.scrollTop = talksPane.scrollHeight;
            },
        },
    };
</script>

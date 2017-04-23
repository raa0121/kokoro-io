<template>
    <div class="talks">
        <div class="row talk" v-for="message in messages.items">
            <div class="col-sm-12">
                <div class="avatar">
                    <img v-bind:src="message.avatar_thumbnail_url" alt="">
                </div>
                <div class="message">
                    <div class="speaker">{{message.speaker.name}}</div>
                    <div class="timeleft pull-right">{{message.postedAt}}</div>
                    <div class="filtered_text">{{message.text}}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
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
            this.eventBus.$on('say', (room, message) => {
                this.roomMessages[room.id].items.push(message);
            });
            this.eventBus.$on('changeRoom', this.changeRoom);
        },

        methods: {
            changeRoom(room){
                console.log('changeRoom', room);
                if(!this.roomMessages[room.id])
                {
                    this.roomMessages[room.id] = {
                        room: room,
                        items: [],
                    };
                }
                Object.assign(this.messages, this.roomMessages[room.id]);
            },
        },
    };
</script>

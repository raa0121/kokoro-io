<template>
    <div class="talks">
        <div class="row talk" v-for="message in messages">
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
    export default {
        props: {
            eventBus: {
                required: true,
            },

            messages: {
                type: Array,
                required: false,
            },
        },

        mounted(){
            this.eventBus.$on('say', (roomId, message) => {
                this.messages.push(message);
            });
        },
    };
</script>

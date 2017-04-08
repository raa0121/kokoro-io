<template>
    <div>
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
    };
</script>

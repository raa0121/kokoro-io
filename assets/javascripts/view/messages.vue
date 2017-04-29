<template>
    <div class="talks">
        <div class="talk" v-for="message in messages.items">
            <div class="avatar" ref="avatar" data-toggle="popover" data-content="Some content">
                <img v-bind:src="message.profile.avatar" alt="">
            </div>
            <div class="message">
                <div class="speaker">{{message.profile.display_name}}<small class="timeleft text-muted">{{timestamp(message)}}</small></div>
                <div class="filtered_text">{{message.content}}</div>
            </div>
        </div>
    </div>
</template>

<script src="./messages.js"></script>

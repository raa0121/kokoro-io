<template>
    <div ref="talksPane" class="talks" @scroll="scroll">
        <loading v-if="fetching" />
        <div v-if="currentRoom.nobodyPost" class="nobody_post">
            <i class="fa fa-info-circle" aria-hidden="true"></i>発言がまだありません
        </div>
        <div v-else-if="currentRoom.reachedEnd" class="no_message_notice">
            <i class="fa fa-rocket" aria-hidden="true"></i>これより過去の発言はありません<i class="fa fa-rocket" aria-hidden="true"></i>
        </div>
        <div class="talk" v-for="message in currentRoom.messages" v-bind:data-message-id="message.id">
            <div class="avatar" ref="avatar" data-toggle="popover" v-bind:data-content="message.profile.display_name">
                <img class="img-rounded" v-bind:src="message.profile.avatar" v-bind:alt="message.profile.display_name">
            </div>
            <div class="message">
                <div class="speaker">{{message.profile.display_name}}<small class="timeleft text-muted">{{timestamp(message)}}</small></div>
                <div class="filtered_text" v-html="message.content"></div>
            </div>
        </div>
    </div>
</template>

<script src="./script.ts"></script>
<style src="./style.css"></style>

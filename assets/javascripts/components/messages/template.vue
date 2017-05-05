<template>
    <div ref="talksPane" class="talks" @scroll="scroll">
        <loading v-if="fetching" />
        <div class="talk" ref="talkRow" v-for="message in currentRoom.messages">
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

<template>
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav nav-sidebar">
            <li v-bind:class="{ active: isActive(room) }" v-on:click.capture.prevent="changeRoom(room)" v-for="room in rooms">
                <a v-bind:href="roomUrl(room)"><span v-if="room.unread_count > 0" class="badge pull-right">{{room.unread_count}}</span>{{room.screen_name}}<i class="fa fa-lock" v-if="room.private" /></a>
            </li>
        </ul>
        <div class="profiles">
          <a href="/@user"><img src="/assets/default_avatar_18-061e9a0d129a0480cdcf0dd1bbafbabc7fbec8aa9130b6b373c08b4f524b666a.png" /></a>
          <a href="/@user"><img src="/assets/default_avatar_18-061e9a0d129a0480cdcf0dd1bbafbabc7fbec8aa9130b6b373c08b4f524b666a.png" /></a>
          <a href="/@user"><img src="/assets/default_avatar_18-061e9a0d129a0480cdcf0dd1bbafbabc7fbec8aa9130b6b373c08b4f524b666a.png" /></a>
          <a href="/@user"><img src="/assets/default_avatar_18-061e9a0d129a0480cdcf0dd1bbafbabc7fbec8aa9130b6b373c08b4f524b666a.png" /></a>
        </div>
    </div>
</template>

<script src="./script.js"></script>
<style src="./style.css"></style>

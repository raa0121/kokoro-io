<template>
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav nav-sidebar">
            <li v-bind:class="{ active: isActive(room) }" v-on:click.capture.prevent="changeRoom(room)" v-for="room in rooms">
                <a v-bind:href="roomUrl(room)"><span v-if="room.unread_count > 0" class="badge pull-right">{{room.unread_count}}</span>{{room.screen_name}}<i class="fa fa-lock" v-if="room.private" /></a>
            </li>
        </ul>
    </div>
</template>

<script src="./rooms.js"></script>

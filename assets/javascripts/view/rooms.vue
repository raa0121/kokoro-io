<template>
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav nav-sidebar">
            <li v-bind:class="{ active: isActive(room) }" v-on:click.capture.prevent="changeRoom(room)" v-for="room in rooms">
                <a v-bind:href="roomUrl(room)"><span class="badge pull-right">1</span>{{room.screen_name}}<i class="fa fa-lock" v-if="room.private" /></a>
            </li>
        </ul>
    </div>
</template>

<script src="./rooms.js"></script>

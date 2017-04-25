<template>
    <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav nav-sidebar">
            <li v-bind:class="{ active: isActive(room) }" v-on:click.capture.prevent="changeRoom(room)" v-for="room in rooms">
                <a v-bind:href="roomUrl(room)"><span class="badge pull-right">1</span>{{room.screen_name}}</a>
            </li>
        </ul>
        <hr>
        <a class="btn btn-primary btn-block btn-sm" href="/rooms/new">Create room</a>
        <a class="btn btn-default btn-block btn-sm" href="/rooms">Join room</a>
    </div>
</template>

<script>
    export default {
        props: {
            eventBus: {
                required: true,
            },
        },

        data(){
            return {
                // memo: [{
                //   "id":1,
                //   "display_name":"aaaa",
                //   "screen_name":"aaaa",
                //   "private":false,
                //   "created_at":"2017-04-22T11:00:02.354Z",
                //   "updated_at":"2017-04-22T11:00:02.354Z",
                //   "description":"eeee",
                // }]
                rooms: [],
                room: {},
            };
        },

        mounted(){
            const promise = this.$http.get(`/v1/rooms`);
            promise.then(response => {
                console.log(response);
                this.rooms = [];
                (response.data || []).forEach(room => this.rooms.push(room));
                if(this.rooms.length > 0) {
                  this.changeRoom(this.rooms[0]);
                }
            });
        },

        methods: {
            roomUrl(room){
                return `/rooms/${room.display_name}`;
            },

            changeRoom(room){
                this.room = room;
                this.$emit('changeRoom', room);
                this.eventBus.$emit('changeRoom', room);
            },

            isActive(room){
                return this.room.id == room.id;
            },
        },
    };
</script>

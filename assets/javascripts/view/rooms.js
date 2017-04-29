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
        this.eventBus.$on('chatChannelConnected', () => {
            this.rooms.forEach(room => {
                this.$emit('subscribeRoom', room);
                this.eventBus.$emit('subscribeRoom', room);
            });
        });
        const promise = this.$http.get(`/v1/rooms`);
        promise.then(response => {
            console.log(response);
            this.rooms = [];
            (response.data || []).forEach(room => {
                this.rooms.push(room);
                this.$emit('subscribeRoom', room);
                this.eventBus.$emit('subscribeRoom', room);
            });
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

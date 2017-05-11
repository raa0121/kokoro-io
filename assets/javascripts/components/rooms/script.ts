export default {
    props: {
        eventBus: {
            required: true,
        },
    },

    data(){
        return {
            rooms: [],
            room: {},
        };
    },

    computed: {
        unreadMessageCount(){
            return this.rooms.map((room) => {
                return room.unread_count;
            }).reduce((a, b) => {
                return a + b;
            });
        },
    },

    mounted(){
        this.eventBus.$on('chatChannelConnected', () => {
            this.rooms.forEach(room => {
                this.$emit('subscribeRoom', room);
                this.eventBus.$emit('subscribeRoom', room);
            });
        });
        this.eventBus.$on('messageReceived', (room, message) => {
            if(this.room.id != room.id){
                const targetRoom = this.rooms.find((elm, idx, arr) => {
                    return elm.id == room.id;
                })
                if(targetRoom){
                    targetRoom.unread_count += 1;
                    this.$config.updateTitle(this.unreadMessageCount);
                }
            }
        });
        const promise = this.$http.get(`/v1/rooms`);
        promise.then(response => {
            console.log(response);
            this.rooms = [];
            (response.data || []).forEach(room => {
                room.unread_count = 0;
                room.shown = false;
                this.rooms.push(room);
                this.$emit('subscribeRoom', room);
                this.eventBus.$emit('subscribeRoom', room);
            });

            // select initial room
            this.$config.getActiveRoom().then(room => {
                room || (room = this.rooms[0]);
                if(!!room)
                {
                    this.changeRoom(room);
                }
            });
        });
    },

    methods: {
        roomUrl(room){
            return `/rooms/${room.display_name}`;
        },

        changeRoom(room){
            this.room = room;
            this.room.unread_count = 0;
            this.$config.updateTitle(this.unreadMessageCount);
            this.room.shown = true;
            this.$emit('changeRoom', room);
            this.eventBus.$emit('changeRoom', room);
        },

        isActive(room): boolean {
            return this.room.id == room.id;
        },
    },
};

import moment from 'moment';
window.moment= moment;

export default {
    props: {
        eventBus: {
            required: true,
        },
    },

    data(){
        return {
            messages: {
                room: {},

                items: [],
            },

            // room.id => messages
            roomMessages: {},
        };
    },

    mounted(){
        this.eventBus.$on('postingMessage', (room, message) => {
            this.roomMessages[room.screen_name].items.push(message);
        });
        this.eventBus.$on('removeTemporaryMessage', (room, removalMessage) => {
            const messages = this.roomMessages[room.screen_name];
            messages.items = messages.items.filter(
                message => !!message.id &&
                    !( message.transitNumber &&
                       message.transitNumber == removalMessage.transitNumber)
            );
        });
        this.eventBus.$on('messageReceived', (room, message) => {
            this.roomMessages[room.screen_name].items.push(message);
        });
        this.eventBus.$on('changeRoom', this.changeRoom);
    },

    updated(){
        this.scrollToLatestTalk();

        (this.$refs.avatar || []).forEach(el => {
            $(el).popover({
                placement: 'auto',
                trigger: 'hover',
            });
        });
    },

    methods: {
        changeRoom(room){
            console.log('changeRoom', room);
            if(!this.roomMessages[room.screen_name])
            {
                this.roomMessages[room.screen_name] = {
                    room: room,
                    items: [],
                };
            }
            // set reference
            const messages = this.roomMessages[room.screen_name];
            this.messages = messages;

            // read initial data
            const promise = this.$http.get(`/v1/rooms/${room.screen_name}/messages`, {
                params: {
                    limit: 30,
                    offset: 0,
                },
            });
            promise.then(response => {
                (response.data || []).reverse().forEach(message => messages.items.push(message));
            });
        },

        scrollToLatestTalk(){
            const talksPane = document.querySelector(".talks");
            talksPane.scrollTop = talksPane.scrollHeight;
        },

        timestamp(message){
            console.log('message', JSON.stringify(message));
            const now = moment.utc();
            const publishedAt = moment.utc(message.published_at);
            const durationSeconds = now.unix() - publishedAt.unix();
            const duration = moment.duration(durationSeconds, 'seconds');
            // in this minute
            if(durationSeconds < 60)
            {
                return 'Now';
            }
            // in this hour
            else if(durationSeconds < 3600)
            {
                return `${duration.minutes()} minutes ago`;
            }
            // in this day
            else if(durationSeconds < 86400)
            {
                return `${duration.hours()} hours ago`;
            }
            // other
            else
            {
                return `${duration.days()} days ago`;
            }
        },
    },
};

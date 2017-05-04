import * as moment from 'moment';
import * as Rx from 'rx';

// tick! tack! globaly
const ticker$ = Rx.Observable.interval(1000);

export default {
    props: {
        eventBus: {
            required: true,
        },
    },

    data(){
        return {
            now: moment.utc(),

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
            this.$nextTick(() => this.scrollToLatestTalk());
        });
        this.eventBus.$on('changeRoom', this.changeRoom);

        ticker$.subscribe(() => this.now = moment.utc());
    },

    updated(){
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
                // read initial data
                const promise = this.$http.get(`/v1/rooms/${room.screen_name}/messages`, {
                    params: {
                        limit: 30,
                        offset: 0,
                    },
                });
                promise.then(response => {
                    (response.data || []).reverse().forEach(message => messages.items.push(message));
                    this.$nextTick(() => this.scrollToLatestTalk());
                });
            }
            // set reference
            const messages = this.roomMessages[room.screen_name];
            this.messages = messages;
            this.$nextTick(() => this.scrollToLatestTalk());
        },

        scrollToLatestTalk(){
            const el = this.$refs.talksPane;
            if(!!el)
            {
                el.scrollTop = el.scrollHeight;
            }
        },

        timestamp(message){
            const publishedAt = moment.utc(message.published_at);
            const durationSeconds = this.now.unix() - publishedAt.unix();
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

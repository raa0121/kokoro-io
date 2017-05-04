import moment from 'moment';
import Rx from 'rx';
import LoadingView from '../loading/template.vue';

// tick! tack! globaly
const ticker$ = Rx.Observable.interval(1000);

// max number of fetching messages once.
const MAX_LIMIT = 200;

export default {
    props: {
        eventBus: {
            required: true,
        },
    },

    components: {
        loading: LoadingView
    },

    data(){
        return {
            fetching: false,
            requestParams: {
                limit: 20,
                before_id: null,
            },
            now: moment.utc(),
            messages: {
                room: {},
                items: [],
            },
            // room.id => messages
            roomMessages: {},
            currentRoom: null,
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
            this.currentRoom = room;
            console.log('changeRoom', this.currentRoom);
            if(!this.roomMessages[this.currentRoom.screen_name])
            {
                this.roomMessages[this.currentRoom.screen_name] = {
                    room: this.currentRoom,
                    items: [],
                };
                // fetch initial data
                this.fetch();
            }
            // set reference
            this.messages = this.roomMessages[this.currentRoom.screen_name];
            this.$nextTick(() => this.scrollToLatestTalk());
        },

        fetch() {
            this.fetching = true;
            this.$http.get(
                `/v1/rooms/${this.currentRoom.screen_name}/messages`,
                { params: { limit: this.requestParams.limit, before_id: this.requestParams.before_id }}
            ).then(response => {
                this.fetching = false;
                (response.data || []).reverse().forEach(message => this.messages.items.push(message));
                this.$nextTick(() => this.scrollToLatestTalk());
            });
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

        scroll(el) {
            if ((el.target.scrollTop === 0)) {
                if (this.messages.items.length > 0) {
                    this.requestParams.limit = Math.min(Math.round(this.requestParams.limit * 1.5), MAX_LIMIT);
                    this.requestParams.before_id = this.messages.items.slice(-1)[0].id;
                }
                this.fetch();
            }
        },
    },
};

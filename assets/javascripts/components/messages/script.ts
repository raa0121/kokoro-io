import * as moment from 'moment';
import * as Rx from 'rx';
const LoadingView = require('../loading/template.vue');

// tick! tack! globaly
const ticker$ = Rx.Observable.interval(1000);

// controling scroll
const MAX_LIMIT = 200;
const displayUnreadNum = 1;

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
            now: moment.utc(),
            currentRoom: {
                id: null,
                requestParams: { limit: 30, before_id: null },
                screenName: null,
                messages:[],
                reachedEnd: false,
                nobodyPost: false,
                initialized: false,
            },
            rooms: {},
        };
    },

    mounted(){
        this.eventBus.$on('postingMessage', (room, message) => {
            this.rooms[room.id].nobodyPost = false;
            this.rooms[room.id].messages.push(message);
        });
        this.eventBus.$on('removeTemporaryMessage', (room, removalMessage) => {
            this.currentRoom.messages = this.rooms[room.id].messages.filter(
                message => !!message.id &&
                    !( message.transitNumber &&
                       message.transitNumber == removalMessage.transitNumber)
            );
        });
        this.eventBus.$on('messageReceived', (room, message) => {
            this.rooms[room.id].messages.push(message);
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
            this.currentRoom = this.rooms[room.id];
            if(!this.currentRoom) {
                this.rooms[room.id] = this.currentRoom = {
                    id: room.id,
                    screenName: room.screen_name,
                    requestParams: { limit: 30, before_id: null },
                    initialized: false,
                    messages: [],
                    reachedEnd: false,
                    nobodyPost: false,
                };
                // fetch initial data
                this.fetch().then(fetchedData => {
                    if (fetchedData.length === 0) this.currentRoom.nobodyPost = true;
                    this.$nextTick(() => {
                        this.scrollToLatestTalk();
                        const images = document.querySelectorAll('img.thumb');
                        let loaded = 0;
                        for (let i=0; i < images.length; i++) {
                            // NOTE: Wait for finishing load all of images.
                            images[i].addEventListener('load', () => {
                                loaded = loaded + 1;
                                if (loaded === images.length) this.scrollToLatestTalk();
                            });
                        }
                    });
                    this.currentRoom.initialized = true;
                });
            }
            this.$nextTick(() => this.scrollToLatestTalk());
        },

        fetch() {
            this.fetching = true;
            return this.$http.get(
                `/v1/rooms/${this.currentRoom.id}/messages`,
                { params: this.currentRoom.requestParams }
            ).then(response => {
                this.fetching = false;
                (response.data || []).forEach(message => this.currentRoom.messages.unshift(message));
                this.currentRoom.reachedEnd = response.data.length === 0 || response.data.length < this.currentRoom.requestParams.limit;
                return response.data;
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

        scroll(ev) {
            // NOTE: This handler is also called when a room is changed.
            //       So `this.currentRoom` maybe a previous room.
            const room = this.rooms[this.currentRoom.id];
            if (ev.target.scrollTop === 0 && room.initialized && !room.reachedEnd) {
                if (this.currentRoom.messages.length > 0) {
                    room.requestParams.limit = Math.min(Math.round(room.requestParams.limit * 1.5), MAX_LIMIT);
                    room.requestParams.before_id = this.currentRoom.messages[0].id;
                }
                const displayedHeight = this.$refs.talksPane.scrollHeight;
                this.fetch().then(fetchedData => {
                    this.$nextTick(() => {
                        if (fetchedData.length === 0) return;
                        let scrollRange = 0;
                        for (let i=0; i < displayUnreadNum; i++) {
                            scrollRange = scrollRange + document.querySelector(`.talk[data-message-id="${fetchedData[i].id}"]`).clientHeight;
                        }
                        this.$refs.talksPane.scrollTop = this.$refs.talksPane.scrollHeight - displayedHeight - scrollRange;
                    });
                });
            }
        },
    },
};

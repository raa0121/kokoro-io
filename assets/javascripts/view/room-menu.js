export default {
    props: {
        eventBus: {
            required: true,
        },
    },

    data(){
        return {
            room: {},
            isSoundEnabled: true,
        };
    },

    mounted(){
        this.eventBus.$on('changeRoom', (room) => {
            this.room = room;
        });
        this.$config.isSoundEnabled().then((enabled) => {
            this.isSoundEnabled = enabled;
        });
    },

    updated(){
        $('.room-menu a[data-toggle="tooltip"]').tooltip(
            {
                container: 'body'
            }
        );
    },

    methods: {
        toggleSoundEnabled(evt) {
            this.$config.isSoundEnabled().then((enabled) => {
                this.$config.setSoundEnabled(!enabled);
                this.isSoundEnabled = !enabled;
            });
        }
    },
};

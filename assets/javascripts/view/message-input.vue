<template>
    <textarea id="say_text" placeholder="Let's talk!" v-bind:disabled="suppressingInput" v-model="text" v-on:keypress="maybeSay($event)"></textarea>
</template>

<script>
    import KeyCode from 'keycode-js';

    export default {
        data(){
            return {
                suppressingInput: false,
                text: '',
            };
        },

        methods: {
            maybeSay(evt){
                switch(evt.keyCode || evt.which)
                {
                    case KeyCode.KEY_ENTER:
                    case KeyCode.KEY_RETURN:
                        // Shift+Enter = New line
                        if(!!evt.shiftKey)
                        {
                            return true;
                        }
                        evt.preventDefault();
                        // TODO: Post message
                        this.suppressingInput= true;
                        setTimeout(() => {
                            alert(this.text);
                            this.text= '';
                            this.suppressingInput= false;
                        }, 1000);
                        return false;
                }
            },
        },
    };
</script>

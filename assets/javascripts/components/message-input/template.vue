<template>
    <textarea v-focus ref="sayWidget" name="say_text" id="say_text" placeholder="Let's talk!" v-bind:rows="inputLines" v-bind:disabled="disabled" v-model="text" v-on:keypress="maybeSay($event)"></textarea>
</template>

<script src="./script.ts"></script>

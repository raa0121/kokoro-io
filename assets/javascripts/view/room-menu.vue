<template>
    <div class="room-menu">
      <a href="#" id="toggle-volume" v-on:click="toggleSoundEnabled($event)" data-toggle="tooltip" data-placement="left" title="通知音を鳴らす">
        <i v-bind:class="{ 'fa-volume-up': isSoundEnabled, 'fa-volume-off': !isSoundEnabled }" class="fa"></i>
      </a>
      <a href="#" id="invite-member" v-on:click="" data-toggle="tooltip" data-placement="left" title="ユーザーを招待（WIP）">
        <i class="fa fa-user-plus"></i>
      </a>
      <a href="#" id="search-log"    v-on:click="" data-toggle="tooltip" data-placement="left" title="過去ログを検索（WIP）">
        <i class="fa fa-search"></i>
      </a>
    </div>
</template>

<script src="./room-menu.js"></script>
<style src="./room-menu.css"></style>

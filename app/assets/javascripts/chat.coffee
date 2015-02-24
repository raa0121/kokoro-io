#= require vue

$ ->
  new Vue
    el: '#chatapp'
    data:
      rooms: []
      active_room: ''
      say_text: ''
    computed:
      say_text_rows:
        get: ->
          this.say_text.split("\n").length
    methods:
      say: ->
        text = this.say_text
        # room = this.rooms[this.active_room]
        if (!text)
          return
        console.log text
        this.say_text = ''



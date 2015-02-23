#= require vue

$ ->
  new Vue
    el: '#say_text'
    data:
      msg: ''
    computed:
      rows:
        get: ->
          this.msg.split("\n").length + 1


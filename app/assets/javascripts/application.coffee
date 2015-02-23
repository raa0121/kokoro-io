#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
# require bootstrap/affix
#= require bootstrap/alert
# require bootstrap/button
# require bootstrap/carousel
#= require bootstrap/collapse
#= require bootstrap/dropdown
# require bootstrap/tab
# require bootstrap/transition
# require bootstrap/scrollspy
# require bootstrap/modal
#= require bootstrap/tooltip
#= require bootstrap/popover
#= require turbolinks
# require_tree .


# https://github.com/kossnocorp/jquery.turbolinks

$ ->
  $('.popover-userinfo').popover
    placement: 'auto'
    trigger: 'hover'


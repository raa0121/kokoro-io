#= require opal
#= require opal_ujs
#= require native

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


Element.expose :alert
Element.expose :collapse
Element.expose :dropdown
Element.expose :tooltip
Element.expose :popover
Document.ready? do
  Element.find('.popover-userinfo').popover({placement: 'auto', trigger: 'hover'}.to_n)
end


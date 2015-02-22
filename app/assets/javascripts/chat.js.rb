#= require vue

Document.ready? do
  Vue = Native(`Vue.prototype`)
  say = Vue._init({
        el: '#say_text',
        data: {
          msg: "a\nb\nc\n\n\nd"
        },
        computed: {
          rows: {
            get: ->{`this.msg`.lines.size + 1}
          }
        }
      }.to_n)
end


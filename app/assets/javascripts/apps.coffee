$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#app_hidden', (e) ->
    if $(@).val() == 'true'
      $("#app_hidden_at").val(new Date())
    else
      $("#app_hidden_at").val(null)

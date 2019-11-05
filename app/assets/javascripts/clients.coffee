$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#client_hidden', (e) ->
    if $(@).val() == 'true'
      $("#client_hidden_at").val(new Date())
    else
      $("#client_hidden_at").val(null)

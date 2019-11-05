$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#user_hidden', (e) ->
    if $(@).val() == 'true'
      $("#user_hidden_at").val(new Date())
    else
      $("#user_hidden_at").val(null)

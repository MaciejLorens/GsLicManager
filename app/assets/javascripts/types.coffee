$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#type_hidden', (e) ->
    if $(@).val() == 'true'
      $("#type_hidden_at").val(new Date())
    else
      $("#type_hidden_at").val(null)

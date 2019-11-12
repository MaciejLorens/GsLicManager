$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#license_hidden', (e) ->
    if $(@).val() == 'true'
      $("#license_hidden_at").val(new Date())
    else
      $("#license_hidden_at").val(null)

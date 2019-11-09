$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#version_hidden', (e) ->
    if $(@).val() == 'true'
      $("#versionhidden_at").val(new Date())
    else
      $("#version_hidden_at").val(null)

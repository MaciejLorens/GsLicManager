$(document).on 'turbolinks:load', ->

  $("body").on 'change', '#license_hidden', (e) ->
    if $(@).val() == 'true'
      $("#license_hidden_at").val(new Date())
    else
      $("#license_hidden_at").val(null)

  show_proper_versions()
  show_proper_plans()

  $("#license_app_id").change ->
    show_proper_versions()
    show_proper_plans()


show_proper_versions = () ->
  app_id = $("#license_app_id").val()
  $("#license_version_id option").hide()
  versions_for_app = $("#license_version_id option[data-app_id=" + app_id + "]")
  versions_for_app.show()
  $("#license_version_id").val(versions_for_app[0].value)

show_proper_plans = () ->
  app_id = $("#license_app_id").val()
  $("#license_plan_id option").hide()
  plans_for_app = $("#license_plan_id option[data-app_id=" + app_id + "]")
  plans_for_app.show()
  $("#license_plan_id").val(plans_for_app[0].value)

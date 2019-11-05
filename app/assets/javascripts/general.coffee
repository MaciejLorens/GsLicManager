$(document).on 'turbolinks:load', ->
  setTimeout ->
    $(".alert").fadeOut(500)
  , 2000


  batch_delete_message = (ids)->
    message = ''
    if $("#current_user_locale").val() == 'pl'
      message = 'Czy jesteś pewien że chcesz usunąć ' + ids.length
      if ids.length == 1
        message += ' rekord?'
      else if ids.length < 5
        message += ' rekordy?'
      else
        message += ' rekordów?'
    else
      message = 'Are you sure you want to delete ' + ids.length
      if ids.length == 1
        message += ' record?'
      else
        message += ' records?'
    return message


  no_records_selected_message = ->
    message = ''
    if $("#current_user_locale").val() == 'pl'
      message += 'Brak zaznaczonych rekordów'
    else
      message += 'No resources selected'
    message


  $("body").on 'click', '.batch-destroy', (e) ->
    e.preventDefault()

    url = $(@).prop('href')
    ids = []

    $(".list-checkbox").each (index) ->
      if $(@).prop('checked')
        ids.push $(@).data('id')

    if ids.length == 0
      alert('No resources selected')
    else
      if confirm(batch_delete_message(ids))
        $.ajax {
          url: url,
          type: 'DELETE',
          data: {ids: ids}
        }


  $("body").on 'click', '.sort-link', (e) ->
    e.preventDefault()

    field = $(@).data('field')
    $("#s_field").val(field)
    if $(@).hasClass('asc')
      $("#s_order").val('desc')
    else
      $("#s_order").val('asc')

    $(".filter-form").submit()

$(document).on "ready page:change", ->

  $('form').on "click", ".remove-fields", (event) ->
    $(this).prev("input[type=hidden]").val "1"
    $(this).closest("div.form-group").hide()
    event.preventDefault()

  $('.add-fields').off('click').on 'click', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
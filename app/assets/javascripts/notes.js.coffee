jQuery ->
  window.noteForm = new ModalForm "note-modal-template"
  $("#notes-left div.note").popover { placement:"left", content:"data-description", title:"data-title" }
  $("#notes-right div.note").popover { placement:"right", content:"data-description", title:"data-title" }
  
  window.notes = $("div.note").toArray().reduce (memo, val) ->
    el  = val
    val = $(val)
    memo[val.data "note-date"]                  ?= {}
    memo[val.data "note-date"][val.data "hour"] = new Note(el)
    memo
  , {}
    
class MsgBox
  constructor: (@container_id) ->
    @box = $("##{@container_id}")
    @status = null
  
  hide_errors: =>
    @box.find('.error').hide()
  
  hide_notices: =>
    @box.find('.notice').hide()
  
  hide: =>
    @box.hide()
  
  show_errors: =>
    @box.find("ul").show()
  
  show_notices: =>
    @box.find(".notice").show()
  
  show: (@status, messages) =>
    
    if (@status == 'error')
      @hide_notices()
      @box.find("ul > li").remove()
      html = messages.reduce (html, val) ->
        html += "<li>#{val}</li>"
      , ""

      @box.find("ul").first().append html
      @show_errors()
    else
      @hide_errors()
      @box.find('.notice').first().text messages
      @show_notices()
    
    @box.show()
      
      
    
class ModalForm
  constructor: (@modal_finder_str) ->
    @modal_content    = $("##{@modal_finder_str}")
    @modal_form       = $(@modal_content.find("form").first())
    @message_box      = new MsgBox("submit-result-msg")
    
    @modal_content.bind "show", @update_fields_and_attributes
    @modal_content.bind "hide", @note_container_update
    @modal_form.bind("ajax:beforeSend", @toggle_form_state)
    .bind("ajax:success", @success)
    .bind("ajax:error", @error)
    
  toggle_form: =>
    if @modal_form.find("input:enabled").size > 0
      @modal_form.find("input, textarea").attr "disabled", true
    else
      @modal_form.find("input, textarea").removeAttr "disabled"
  
  toggle_loading: =>
    @modal_form.find(".actions > button, .actions > input").toggle()
    @modal_form.find(".actions > #form-loader").toggle()
  
  toggle_form_state: =>
    @toggle_loading()
    @toggle_form()
    @message_box.hide()

  success: (event, data, status, xhr) =>
    @toggle_form_state()
    response = jQuery.parseJSON(xhr.responseText)
    @note_id = response["note_id"] if response["note_id"]
    @message_box.show(status, response["notice"])
    setTimeout (=> @modal_content.modal('hide') ), 1500
    
    
  error: (event, xhr, status, error) =>
    @toggle_form_state()
    @message_box.show(status, jQuery.parseJSON(xhr.responseText))
    
  show_modal: (@description, @title, @date, @hour, @action, @note_id) =>
    @modal_content.modal { backdrop:true, keyboard:true, show:true }
    
  update_fields_and_attributes: =>
    #setting values to inputs
    @modal_form.find("input#note_title").first().val @title
    @modal_form.find("textarea#note_description").first().val @description
    @modal_form.find("input#note_planned_time").first().val "#{@date} #{@hour}:00:00"

    # if existing record (id is not blank) we add hidden input to show it's an update
    if @note_id.match(/[0-9]/)
      @modal_form.find("input[name=authenticity_token]").first().parent().append("<input type=\"hidden\" name=\"_method\" value=\"put\">")
    else
      @modal_form.find("input[name=_method]").first().remove()

    #form action
    @modal_form.attr "action", @action

    #adjusting form header
    @modal_content.find('h3').text "Edit note for #{@date} #{@hour}:00"
  
  note_container_update: =>
    if @message_box.status == "success"
      window.notes["#{@date}"]["#{@hour}"].update(@modal_form.serializeArray(), @note_id)
    
    @message_box.hide()
    @message_box.status = null
    
    
    
class Note
  constructor: (el) ->
    @note_dom         = $(el)
    @note_id          = @note_dom.attr 'id'
        
    @note_dom.click @click
    
  click: =>
    description     = @note_dom.data "description"
    title           = @note_dom.data "title"
    date            = @note_dom.data "note-date"
    hour            = @note_dom.data "hour"
    action          = @note_dom.data "action"
    
    window.noteForm.show_modal description, title, date, hour, action, @note_id
  
  update: (fields, note_id) =>
    for val in fields
      if attr = val.name.match(/note\[(title|description)\]/)
        @note_dom.attr "data-#{attr[1]}", val.value
        @note_dom.find(".note-title").first().text val.value if attr[1] == 'title'
    unless @note_id.match /[0-9]/
      @note_id = note_id
      @note_dom.attr "data-action", "#{@note_dom.data("action")}/#{note_id}"
      @note_dom.attr "id", "#{@note_dom.attr 'id'}#{note_id}"
    
    

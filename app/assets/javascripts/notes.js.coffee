jQuery ->
  $("#notes-left div.note").popover { placement:"left" }
  $("#notes-right div.note").popover { placement:"right" }
  for el in $("div.note")
    new Note(el)
  
class Note
  constructor: (el)->
    @note_dom         = $(el)
    @note_id          = @note_dom.attr 'id'
    @modal_finder_str = "note-modal-template"
    
    @note_dom.click @click
  
  click: =>
    @modal_content  = $("##{@modal_finder_str}")
    description     = @note_dom.data "content"
    title           = @note_dom.data "original-title"
    
    @modal_content.find('h3').text title
    @modal_content.find('.modal-body p').text description
    @modal_content.modal { backdrop:true, keyboard:true }

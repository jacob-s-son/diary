module NotesHelper
  def note_entries(notes, date)
    (0..23).map do |i|
      note = notes.detect{ |n| n.planned_time.to_date == date && n.planned_time.hour == i } || Note.new
      {:note => note, :hour => i }
    end
  end
end

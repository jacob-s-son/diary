namespace :sample_data do
  desc "Adding sample notes to DB"
  task :add_notes_to_user, [:user_id, :number_of_notes] => :environment do |t, args|
    args.with_defaults(:user_id => 1, :number_of_notes => 5)
    args[:number_of_notes] = 11 if args[:number_of_notes].to_i > 11
    
    (1..args[:number_of_notes].to_i).each do |i|
      FactoryGirl.create :note_for_particular_day, :user_id => args[:user_id], :planned_time => Date.today.to_time + ( i + 12 ).hours
      FactoryGirl.create :note_for_particular_day, :user_id => args[:user_id], :planned_time => Date.today.next_day.to_time + ( i + 12 ).hours
    end
  end
end
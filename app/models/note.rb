class Note < ActiveRecord::Base
  
  validates :title, :presence => true, :length => { :maximum => 254 }
  validates :planned_time, :presence => true, :uniqueness => { :scope => :user_id }
  validates :description, :length => { :maximum => 2000 }
  validates :user_id, :presence => true, :numericality => true
  
  belongs_to :user
  
  attr_accessible :title, :description, :planned_time
  
  scope :user_notes_for_two_days, lambda {|user, day|
    where ["user_id = ? AND planned_time >= ? AND planned_time < ?", user, day.to_time, (day+2).to_time ]
  }
end

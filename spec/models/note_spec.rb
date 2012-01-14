require 'spec_helper.rb'

describe Note do
  before(:all) do
     FactoryGirl.create_list(:note, 25)
  end
  
  describe "Obligatory fields" do
    OBLIGATORY_FIELDS = [ :title, :planned_time, :user_id ]
    
    OBLIGATORY_FIELDS.each do |field|
      it { should validate_presence_of field }
    end
  end
  
  describe "Field specifics" do
    it { should ensure_length_of(:title).is_at_most(254) }
    it { should ensure_length_of(:description).is_at_most(2000) }
    #FIXME: It's a kind of magic, shouldn't be failing
    it { should validate_uniqueness_of(:planned_time).scoped_to(:user_id)}
  end
  
  describe "Allowed fields for mass assignment" do
    ALLOWED_FIELDS = [ :title, :description, :planned_time ]
    
    ALLOWED_FIELDS.each do |field|
      it { should allow_mass_assignment_of field }
    end
  end
  
  describe "Relationships" do
    it { should belong_to :user }
  end
  
  after(:all) do
    Note.delete_all
    User.delete_all
  end
end
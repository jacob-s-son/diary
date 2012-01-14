require 'spec_helper.rb'

describe Note do
  
  describe "Obligatory fields" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :planned_time }
    it { should validate_presence_of :user_id }
  end
  
  describe "Allowed length of the fields" do
    it { should ensure_length_of(:title).is_at_most(255) }
    it { should ensure_length_of(:description).is_at_most(2000) }
  end
  
  describe "Allowed fields for mass asignment" do
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :planned_time }
    # it { should_not allow_mass_assignment_of :id }
    # it { should_not allow_mass_assignment_of :user_id }
    # it { should_not allow_mass_assignment_of :created_at }
    # it { should_not allow_mass_assignment_of :updated_at }
  end
  
  describe "Relationships" do
    it { should belong_to :user }
  end
end
require 'spec_helper.rb'

describe User do
  
  describe "Obligatory fields" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
  
  describe "Field format" do
    
    describe "Email" do
      it { should ensure_length_of(:email).is_at_most(255) }
      
      it { should allow_value('jekabsons.edgars@gmail.com').for :email }
      it { should allow_value('edgars-12_34@inbox.lv').for :email }
      
      it { should_not allow_value('jekabsons.edgars@gmail').for :email }
      it { should_not allow_value('jekabsons').for :email }
      it { should_not allow_value('.edgars@gmail.com').for :email }
      it { should_not allow_value('jekabsons.edgars@gmail').for :email }
    end
    
    describe "Password" do
      it { should ensure_length_of(:password).is_at_least(6).is_at_most(255) }
      
      it { should allow_value('Passsword123').for :password }
      it { should allow_value('aLaLa123aLaL').for :password }
      it { should allow_value('_Ala123-Aala').for :password }
      
      it { should_not allow_value('lalalalala').for :password }
      it { should_not allow_value('1234567890').for :password }
      it { should_not allow_value('123lalalal').for :password }
      it { should_not allow_value('L_La-aLaLa').for :password }
      it { should_not allow_value('123_______').for(:password)
                 .with_message("Password should contain at least one character from each of the groups - lowercase letters, uppercase letters, digits")
         }
    end
  end
  
  describe "Allowed fields for mass asignment" do
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    it { should allow_mass_assignment_of :remember_me }
  end
  
  describe "Relationships" do
    it { should have_many :notes }
  end
end
require 'spec_helper.rb'

describe User do
  before(:all) do
     FactoryGirl.create_list(:user, 5)
  end
    
  describe "Obligatory fields" do
    OBLIGATORY_FIELDS = [ :email, :password ]
    
    OBLIGATORY_FIELDS.each do |field|
      it { should validate_presence_of field }
    end
  end
  
  describe "Field specifics" do
    
    describe "Email" do      
      BAD_EMAILS  = ['jekabsons.edgars@gmail', 'jekabsons', '.edgars@gmail.com', 'jekabsons.edgars@gmail']
      GOOD_EMAILS = ['jekabsons.edgars@gmail.com', 'edgars-12_34@inbox.lv']
      
      it { should ensure_length_of(:email).is_at_most(254) }
      it { should validate_uniqueness_of :email }
      
      GOOD_EMAILS.each do |email|
        it { should allow_value(email).for :email }
      end
      
      BAD_EMAILS.each do |email|
        it { should_not allow_value(email).for :email }
      end  
    end
    
    describe "Password" do
      GOOD_PASSWORDS = ['Passsword123', 'aLaLa123aLaL', '_Ala123-Aala']
      BAD_PASSWORDS  = ['lalalalala', '1234567890', '123lalalal', 'L_La-aLaLa', '123_______']
      
      it { should ensure_length_of(:password).is_at_least(6).is_at_most(254) }
      
      GOOD_PASSWORDS.each do |pass|
        it { should allow_value(pass).for :password }
      end
      
      BAD_PASSWORDS.each do |pass|
        it { should_not allow_value(pass).for(:password)
                   .with_message("Password should contain at least one character from each of the groups - lowercase letters, uppercase letters, digits")
           }
      end
    end
  end
  
  describe "Allowed fields for mass asignment" do
    ALLOWED_FIELDS = [ :email, :password, :password_confirmation, :remember_me ]
    
    ALLOWED_FIELDS.each do |field|
      it { should allow_mass_assignment_of field }
    end
  end
  
  describe "Relationships" do
    it { should have_many :notes }
  end
  
  after(:all) do
    User.delete_all
  end
  
end
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  
  validates :password, :confirmation => true,
            :presence => true,
            :length => { :maximum => 254, :minimum => 6 },
            :format => { :with => /^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$/, 
                         :message => "Password should contain at least one character from each of the groups - lowercase letters, uppercase letters, digits" }
  validates :email, :presence => true, 
            :length => { :maximum => 254 }, 
            :format => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/,
            :uniqueness => true
  
  has_many :notes

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end

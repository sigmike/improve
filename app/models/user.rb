class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :registerable, :authenticatable, :recoverable,
         :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_many :questions
end

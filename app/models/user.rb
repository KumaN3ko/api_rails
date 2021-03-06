class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :username, presence: true, uniqueness: {case_sensitive: false}


  devise :database_authenticatable, :registerable, :rememberable, :validatable
end

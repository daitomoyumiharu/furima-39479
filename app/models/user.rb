class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname , presence: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :last_name , presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthday, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

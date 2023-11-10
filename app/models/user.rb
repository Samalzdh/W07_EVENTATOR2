class User < ApplicationRecord
  after_create :welcome_send
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  enum role [:regular, :admin]
  has_many :attendances 
  has_many :events , through: :attendances
  has_many :authored_events, class_name: 'Event', foreign_key: :administrator_id
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end

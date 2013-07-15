class DataManager < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable,  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title_id

  validates_presence_of :first_name,:last_name,:title_id

  # Probably extract this into a titles module later for other entities

  validate :check_title_id

  def check_title_id
    errors.add(:title, 'is not a valid value') unless title_id && title_id >= 0 && title_id < Lookup::Title.length
  end

  def title
    Lookup::Title[title_id] if title_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
end

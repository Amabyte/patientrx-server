class Doctor < ActiveRecord::Base
  validates_presence_of :name, :email
  validates :email, :uniqueness => true, format: {with: Settings.regx_email }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :case

  def self.KEY_NAME
    "doctor"
  end
end

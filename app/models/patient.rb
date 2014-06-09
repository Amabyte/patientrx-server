class Patient < ActiveRecord::Base
  validates_presence_of :name, :email
  validates :email, :uniqueness => true, format: {with: Settings.regx_email }
  has_many :patient_social_accounts, dependent: :destroy
  has_many :cases, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.create_social_patient social_user
    patient = Patient.new(name: social_user[:name], email: social_user[:email], password: Devise.friendly_token.first(8))
    patient.save
    patient
  end

  def self.KEY_NAME
    "patient"
  end
end

class PatientSocialAccount < ActiveRecord::Base
  validates_presence_of :patient_id, :uuid, :provider
  belongs_to :patient
  validates_uniqueness_of :patient_id, :scope => :patient_id
end
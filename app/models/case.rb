class Case < ActiveRecord::Base
  validates_presence_of :patient_id, :name, :age, :gender
  belongs_to :patient
  has_many :case_comments, dependent: :destroy

  def total_case_comments
    case_comments.count
  end

  def total_new_case_comments_by_patient
    case_comments.where(who: Patient.KEY_NAME).count
  end

  def total_new_case_comments_by_doctor
    case_comments.where(who: Doctor.KEY_NAME).count
  end

  def as_json(options = {})
    super({methods: [:total_case_comments, :total_new_case_comments_by_patient, :total_new_case_comments_by_doctor]}.merge(options))
  end
end

class Case < ActiveRecord::Base
  validates_presence_of :patient_id, :name, :age, :gender
  validates_inclusion_of :gender, :in => [I18n.t("gender.male"), I18n.t("gender.female")], :message => "should be '#{I18n.t("gender.male")}'' or '#{I18n.t("gender.female")}'"
  belongs_to :patient
  has_many :case_comments, dependent: :destroy

  def total_case_comments
    case_comments.count
  end

  def first_case_comment
    case_comments.first
  end

  def total_new_case_comments_by_patient
    case_comments.where(who: Patient.KEY_NAME).count
  end

  def total_new_case_comments_by_doctor
    case_comments.where(who: Doctor.KEY_NAME).count
  end

  def as_json(options = {})
    super({methods: [:total_case_comments, :total_new_case_comments_by_patient, :total_new_case_comments_by_doctor, :first_case_comment]}.merge(options))
  end
end

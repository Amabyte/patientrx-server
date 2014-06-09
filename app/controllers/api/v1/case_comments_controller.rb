class Api::V1::CaseCommentsController < InheritedResources::Base
  before_action :authenticate_api_patient!
  after_filter :mark_as_read, only: :index
  respond_to :json

  def create
    @case_comment = CaseComment.new(permitted_params[:case_comment])
    @case_comment.who = Patient.KEY_NAME
    @case_comment.case_id = begin_of_association_chain.id
    create!
  end

  private
    def permitted_params
      params.permit(case_comment: [:message, :image, :audio])
    end

    def mark_as_read
      @case_comments.where(who: Doctor.KEY_NAME).update_all is_new: false
    end
    
  protected
    def begin_of_association_chain
      current_api_patient.cases.find(params[:case_id])
    end
end
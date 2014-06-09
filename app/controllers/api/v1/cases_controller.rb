class Api::V1::CasesController < InheritedResources::Base
  before_action :authenticate_api_patient!
  respond_to :json

  def last
    last = begin_of_association_chain.cases.last
    if last
      respond_with begin_of_association_chain.cases.last
    else
      render :nothing => true, status: :not_found
    end
  end

  private
    def permitted_params
      params.permit(:case => [:name, :age, :gender, :lat, :lag])
    end
    
  protected
    def begin_of_association_chain
      current_api_patient
    end
end
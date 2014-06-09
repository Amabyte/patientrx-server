class Api::V1::CasesController < InheritedResources::Base
  before_action :authenticate_api_patient!
  respond_to :json

  private
    def permitted_params
      params.permit(:case => [:name, :age, :gender, :lat, :lag])
    end
    
  protected
    def begin_of_association_chain
      current_api_patient
    end
end
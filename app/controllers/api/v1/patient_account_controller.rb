class Api::V1::PatientAccountController < ApplicationController
  before_action :authenticate_api_patient!

  respond_to :json
  
  def profile
    respond_with current_api_patient
  end
end
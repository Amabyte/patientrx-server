class Api::V1::PatientAccountController < ApplicationController
  before_action :authenticate_patient!

  respond_to :json
  
  def profile
    respond_with current_patient
  end
end
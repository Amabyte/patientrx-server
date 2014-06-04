class Api::V1::PatientSessionController < ApplicationController
  require 'social_login'
  
  def social_login
    if (params[:provider].present? && params[:token].present?)
      social_user = SocialLogin.get_social_user params
      if social_user[:error].nil? && social_user[:email].present? && social_user[:uuid] && social_user[:provider].present?
        patient = Patient.find_by_email social_user[:email]
        if patient.nil?
          patient = PatientSocialAccount.find_by_uuid_and_provider(social_user[:uuid],social_user[:provider]).try(:patient)
        end
        is_new_patient = false
        if patient.nil?
          is_new_patient = true
          patient = Patient.create_social_patient social_user
        else
          patient.name = social_user[:name]
          patient.save!
        end
        unless patient.errors.empty?
          social_login_error(patient.errors.full_messages, :unprocessable_entity)
        else
          social_account = PatientSocialAccount.new(uuid: social_user[:uuid], provider: social_user[:provider])
          social_account.patient = patient
          social_account.save
          sign_in patient
          response_json = {}
          response_json[:is_new_patient] = is_new_patient
          response_json[:patient] = patient
          render json: response_json, status: :ok
        end
      else
        if social_user[:error].nil? && social_user[:email].blank?
          social_login_error format, I18n.t("social_login.email_not_found"), :not_acceptable
        else
          social_login_error
        end
      end
    else
      social_login_error I18n.t("errors.params_missing"), :bad_request
    end
  end
 
  private

  def social_login_error error = I18n.t("social_login.default_error"), status = :failed_dependency
    result_error = (error.is_a? String) ? [error] : error
    render json: {errors: result_error}, status: status
  end
end
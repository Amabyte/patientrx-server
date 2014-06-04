Patientrx::Application.routes.draw do
  api vendor_string: "patientrx", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        devise_for :patients, :skip => [:registration], controllers: { sessions: "api/v1/patient_session" }
        devise_scope :patient do
          resources :patients, controller: "patient_account", :only =>[] do
            collection do
              post '/social_login', to: :social_login
              get "/profile", to: :profile
            end
          end
        end
      end
    end
  end
end

class RegistrationsController < Devise::RegistrationsController
  protected

    def after_update_path_for(resource)
      profile_path(resource.username)
    end
end

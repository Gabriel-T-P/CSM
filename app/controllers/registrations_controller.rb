class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.valid?
      attach_default_avatar(resource)
    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def after_update_path_for(resource)
    profile_path(resource.username)
  end

  def attach_default_avatar(user)
    name = user.username
    api_url = "https://ui-avatars.com/api/?name=#{name}&size=128&background=random&color=fff"
    response = Faraday.get(api_url)

    if response.success?
      user.avatar.attach(
        io: StringIO.new(response.body),
        filename: "avatar.png",
        content_type: response.headers['content-type']
      )
    else
      Rails.logger.error("Avatar API error: #{response.status} - #{response.body}")
      default_avatar_path = Rails.root.join("app/assets/images/default_avatar.png")
      user.avatar.attach(
        io: File.open(default_avatar_path),
        filename: "default_avatar.png",
        content_type: "image/png"
      )
    end
  end
end

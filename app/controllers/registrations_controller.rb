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
      avatar_url = "https://ui-avatars.com/api/?name=#{name}&background=random&color=fff"

      response = Faraday.get(avatar_url) do |req|
        req.options.timeout = 5
        req.options.open_timeout = 3
        req.headers['Accept'] = 'image/png'
        req.headers['User-Agent'] = 'MyAppBot/1.0'
      end

      user.avatar.attach(
        io: StringIO.new(response.body),
        filename: "avatar.png",
        content_type: response.headers['content-type']
      )
    rescue Faraday::Error => e
      Rails.logger.error("Erro ao tentar buscar avatar para user ##{user.id}: #{e.class} - #{e.message}")
    end
end

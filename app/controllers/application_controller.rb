class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  around_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :first_name, :last_name ])

    update_attrs = [ :password, :password_confirmation, :current_password, :username, :location, :birth_date,
                    :biography, :first_name, :last_name, :gender, :avatar ]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def check_admin
    return redirect_to root_path, alert: I18n.t('error_messages.route_negated') unless current_user.admin?
  end
end

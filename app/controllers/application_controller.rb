class ApplicationController < ActionController::Base
  include Pundit
  include Wor::Paginate
  before_action :authenticate_user!, unless: :devise_controller?, except: [:close_account_do,:activate_account_do]
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  #before_action :authenticate_user!, except: [:close_account_do]
  

  def current_user_get
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse(cookies[:auth_headers])
    expiration_datetime = DateTime.strptime(auth_headers['expiry'], '%s')
    current_user = User.find_by(uid: auth_headers['uid'])

    if current_user &&
       current_user.tokens.key?(auth_headers['client']) &&
       expiration_datetime > DateTime.now
      @current_user = current_user
    end

    @current_user
  end

  def authenticate_current_user
    head :unauthorized if current_user_get.nil?
  end


  def render_errors(message, status = :bad_request)
    Rails.logger.error(message)
    render json: { errors: message }, status: status
  end

  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

end

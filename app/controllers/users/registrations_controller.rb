# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    super
  end

  protected

  def configure_permitted_parameters
    default_attrs = [:user_icon, :username, :email, :password, :password_confirmation]
    added_attrs = [:user_icon, :username, :introduction, :twitter_url, :linkedin_url, :facebook_url, :blog_url]
    devise_parameter_sanitizer.permit :sign_up, keys: default_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end


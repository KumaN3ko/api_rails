class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class QueryError < StandardError; end

  before_action :configure_devise_parameters, if: :devise_controller?

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation)}
  end

  private

    def query(definition, variables = {})
      response = GitHub::Client.query(definition, variables: variables)

      if response.errors.any?
        raise QueryError.new(response.errors[:data].join(", "))
      else
        response.data
      end
    end


end

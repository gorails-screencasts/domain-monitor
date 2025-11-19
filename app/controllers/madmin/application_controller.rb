module Madmin
  class ApplicationController < Madmin::BaseController
    http_basic_authenticate_with(
      name: ENV['ADMIN_USERNAME'] || Rails.application.credentials.dig(:mission_control, :http_basic_auth_user),
      password: ENV['ADMIN_PASSWORD'] || Rails.application.credentials.dig(:mission_control, :http_basic_auth_password)
    )
  end
end

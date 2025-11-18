class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  before_action { redirect_to root_path if authenticated? }

  def new
    cookies[:domain] = params[:domain] if params[:domain].present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for(@user)

      if (domain = cookies.delete(:domain))
        @user.domains.create(name: domain)
      end

      redirect_to domains_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:email_address, :password])
  end
end

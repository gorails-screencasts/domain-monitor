class Checkout::ReturnsController < ApplicationController
  def show
    subscription = Pay.sync(params)
    if subscription&.active?
      Current.user.domains.each { it.sync_later }
      flash[:notice] = "Thanks for subscribing!"
    else
      flash[:alert] = "Something went wrong. Please try again."
    end
    redirect_to domains_path
  end
end

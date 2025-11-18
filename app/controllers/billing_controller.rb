class BillingController < ApplicationController
  def show
    redirect_to Current.user.payment_processor.billing_portal.url, allow_other_host: true
  end
end

class CheckoutController < ApplicationController
  def show
    checkout_session = Current.user.payment_processor.checkout(
      mode: :subscription,
      line_items: "price_1SUA0sDAMNYJGPqRi6eurIuI",
      success_url: checkout_return_url,
      allow_promotion_codes: true
    )
    redirect_to checkout_session.url, allow_other_host: true
  end
end

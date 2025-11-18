class Domains::SyncController < ApplicationController
  before_action :set_domain
  before_action :require_subscription

  def update
    @domain.sync
    redirect_to domains_path
  end

  private

  def set_domain
    @domain = Current.user.domains.find(params[:domain_id])
  end

  def require_subscription
    unless Current.user.payment_processor&.subscribed?
      redirect_to domains_path, alert: "#{view_context.link_to("Subscribe", checkout_path, class: "font-semibold underline", data: {turbo: false})} to sync this domain.".html_safe
    end
  end
end

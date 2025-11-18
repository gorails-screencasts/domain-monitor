class DomainsController < ApplicationController
  def index
    @domains = Current.user.domains.order("#{sort_column} #{sort_direction}")
  end

  def create
    @domain = Current.user.domains.new(domain_params)
    if @domain.save
      redirect_to domains_path
    else
      redirect_to domains_path, alert: @domain.errors.full_messages.first
    end
  end

  def destroy
    Current.user.domains.find(params[:id]).destroy
    redirect_to domains_path
  end

  private

  def domain_params
    params.expect(domain: [:name])
  end

  def sort_column
    allowed = ["name", "expires_at", "last_checked_at"]
    params[:sort].presence_in(allowed) || "expires_at"
  end
  helper_method :sort_column

  def sort_direction
    params[:direction].presence_in(["asc", "desc"]) || "asc"
  end
  helper_method :sort_direction
end

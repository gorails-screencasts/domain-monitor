class Domain::ExpiresSoonJob < ApplicationJob
  def perform
    domains_for_date(1.day.from_now).find_each do |domain|
      DomainMailer.with(domain: domain).expires_soon.deliver_later
    end

    domains_for_date(1.week.from_now).find_each do |domain|
      DomainMailer.with(domain: domain).expires_soon.deliver_later
    end

    domains_for_date(2.weeks.from_now).find_each do |domain|
      DomainMailer.with(domain: domain).expires_soon.deliver_later
    end
  end

  private

  def domains_for_date(date)
    range = date.beginning_of_day..date.end_of_day
    Domain.where(expires_at: range)
  end
end

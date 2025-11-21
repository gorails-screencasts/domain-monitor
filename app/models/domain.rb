class Domain < ApplicationRecord
  belongs_to :user

  normalizes :name, with: -> { it.strip.downcase }

  validates :name, uniqueness: { scope: :user_id }

  broadcasts_refreshes
  after_create_commit :sync_later, if: -> { user.payment_processor&.subscribed? }

  def available? = last_checked_at? && !expires_at?
  def expires_soon? = last_checked_at? && expires_at? && expires_at <= 2.weeks.from_now
  def unknown? = !last_checked_at?

  def sync_later
    Domain::SyncJob.perform_later(self)
  end

  def sync
    update(
      expires_at: rdap_expiration || whois_expiration,
      last_checked_at: Time.current
    )
  end

  def rdap_expiration
    Time.parse(RDAP.domain(name).dig("events").find{ it.dig("eventAction") == "expiration" }.dig("eventDate"))
  rescue RDAP::NotFound, RDAP::SSLError
    nil
  end

  def whois_expiration
    Whois.whois(name).parser.expires_on
  end

  after_update_commit do
    if available? && expires_at_previously_was.present?
      DomainMailer.with(domain: self).available.deliver_later
    end
  end
end

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
    rdap = RDAP.domain(name)
    expiration = Time.parse(rdap.dig("events").find{ it.dig("eventAction") == "expiration" }.dig("eventDate"))
    update(
      expires_at: expiration,
      last_checked_at: Time.current
    )
  rescue RDAP::NotFound, RDAP::SSLError
    update(expires_at: nil, last_checked_at: Time.current)
  end

  after_update_commit do
    if available? && expires_at_previously_was.present?
      DomainMailer.with(domain: self).available.deliver_later
    end
  end
end

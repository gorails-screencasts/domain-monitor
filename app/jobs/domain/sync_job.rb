class Domain::SyncJob < ApplicationJob
  queue_as :default

  def perform(domain)
    domain.sync
  end
end

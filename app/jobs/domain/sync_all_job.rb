class Domain::SyncAllJob < ApplicationJob
  queue_as :default

  def perform
    Pay::Subscription.active.includes(customer: :owner) do |subscription|
      subscription.customer.owner.domains.find_each do
        it.sync_later
      end
    end
  end
end

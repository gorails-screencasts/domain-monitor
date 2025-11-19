class Pay::Stripe::ChargeResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :amount
  attribute :amount_refunded
  attribute :application_fee_amount
  attribute :created_at, form: false
  attribute :currency
  attribute :metadata
  attribute :object
  attribute :processor_id
  attribute :stripe_account
  attribute :type
  attribute :updated_at, form: false
  attribute :payment_method_type
  attribute :brand
  attribute :last4
  attribute :exp_month
  attribute :exp_year
  attribute :email
  attribute :username
  attribute :bank
  attribute :subtotal
  attribute :tax
  attribute :stripe_invoice
  attribute :stripe_receipt_url

  # Associations
  attribute :customer
  attribute :subscription

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  # def self.display_name(record) = record.name

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end

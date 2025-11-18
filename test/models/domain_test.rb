require "test_helper"

class DomainTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "available?" do
    assert domains(:available).available?
    refute domains(:expires_soon).available?
    refute domains(:expires_later).available?
  end

  test "expires_soon?" do
    assert domains(:expires_soon).expires_soon?
    refute domains(:available).expires_soon?
    refute domains(:expires_later).expires_soon?
  end

  test "sends an email when the domain becomes available" do
    domain = domains(:expires_soon)
    domain.update(expires_at: nil)
    assert_enqueued_emails 1
    assert_enqueued_email_with DomainMailer, :available, params: { domain: domain }
  end

  test "does not send email on create" do
    users(:one).domains.create! name: "test.org"
    assert_no_enqueued_emails
  end

  test "does not send email when domain gets renewed" do
    domains(:expires_soon).update expires_at: 2.years.from_now
    assert_no_enqueued_emails
  end
end

require "test_helper"

class DomainMailerTest < ActionMailer::TestCase
  test "available" do
    mail = DomainMailer.available
    assert_equal "Available", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "expires_soon" do
    mail = DomainMailer.expires_soon
    assert_equal "Expires soon", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end

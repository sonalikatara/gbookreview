require 'test_helper'

class GroupRequestMailTest < ActionMailer::TestCase
  test "received" do
    mail = GroupRequestMail.received
    assert_equal "Received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "invited" do
    mail = GroupRequestMail.invited
    assert_equal "Invited", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

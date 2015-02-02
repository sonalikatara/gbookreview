class GroupRequestMail < ActionMailer::Base
 # default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_request_mail.received.subject
  #
  def received(group)
    @group = group

    mail to: "gathertogether2read@gmail.com", subject: "New Group Request"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_request_mail.invited.subject
  #
  def invited(group)
    @group = group

    mail to: @group.email, subject: "Welcome to I Love to Read"    #later change it to @group.email
  end
end

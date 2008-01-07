class UserMailer < ActionMailer::Base
  
  def reminder(user)
    subject 'Your login information at RailsSpace.com'
    from    'RailsSpace <do-not-reply@railsspace.com'
    recipients user.email
    @body           = {}
    # Give body access to the user information.
    @body["user"]   = user
  end
  
  def message(mail)
    subject   mail[:message].subject
    from      'RailsSpace <do-not-reply@railsspace.com>'
    recipients mail[:recipient].email
    body      mail
  end
end

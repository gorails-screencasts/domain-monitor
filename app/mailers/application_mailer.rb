class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@domains.railsbytes.com"
  layout "mailer"
end

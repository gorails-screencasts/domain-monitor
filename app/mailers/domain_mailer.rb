class DomainMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.domain_mailer.available.subject
  #
  def available
    mail to: params[:domain].user.email_address
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.domain_mailer.expires_soon.subject
  #
  def expires_soon
    mail to: params[:domain].user.email_address
  end
end

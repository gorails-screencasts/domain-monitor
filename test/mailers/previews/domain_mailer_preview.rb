# Preview all emails at http://localhost:3000/rails/mailers/domain_mailer
class DomainMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/domain_mailer/available
  def available
    DomainMailer.with(domain: Domain.last).available
  end

  # Preview this email at http://localhost:3000/rails/mailers/domain_mailer/expires_soon
  def expires_soon
    DomainMailer.with(domain: Domain.last).expires_soon
  end
end

class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_me.subject
  #
  def contact_me
    @name, @email, @message, @response = params.values_at(:name, :email, :message, :response)

    mail(
      to: [ENV['EMAIL'], @email],
      subject: "#{@response ? 'Response' : 'No response'} requested from #{@name}"
    )
  end
end

class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def invitation_email(invitation)
    @token = invitation.token
    @email = invitation.email

    mail(to: @email, from: 'robert@gs-software.pl', subject: 'Zaproszenie z GS-Lic-Manager')
  end

end

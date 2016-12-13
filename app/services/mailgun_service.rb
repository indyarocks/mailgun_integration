class MailgunService < ApplicationService

  attr_reader :mg_client
  MAILGUN_DOMAIN = Rails.application.secrets['mailer_host']
  MAILGUN_API_KEY = Rails.application.secrets['mailgun_api_key']

  def initialize
    @mg_client = Mailgun::Client.new MAILGUN_API_KEY
  end

  def send_email(user)
    if is_suppressed?(user)
      user.is_suppressed = true
      user.save
    else
      # Define your message parameters
      activation_url = Rails.application.routes.url_helpers.activate_users_url(host: MAILER_HOST, token: user.token)
      message_params =  { from: 'admin@chandan.com',
                          to:   user.email,
                          subject: 'Activate your account',
                          text:  "Welcome #{user.name}, Please activate your account by clicking this #{activation_url}"
      }

      # Send your message through the client
      mg_client.send_message MAILGUN_DOMAIN, message_params
    end
  end

  private
  def is_suppressed?(user)
    # Bounce
    # Unsubscribe
    # Complaints
    false
  end

end
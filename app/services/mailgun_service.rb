class MailgunService < ApplicationService

  MAILGUN_DOMAIN = Rails.application.secrets['mailer_host']
  MAILGUN_API_KEY = Rails.application.secrets['mailgun_api_key']
  API_BASE_URL = "https://api:#{MAILGUN_API_KEY}@api.mailgun.net/v3/#{MAILGUN_DOMAIN}"

  def self.send_activation_email(user)
    if is_email_suppressed?(user.email)
      user.is_suppressed = true
      user.save
    else
      # Define your message parameters
      activation_url = Rails.application.routes.url_helpers.activate_users_url(host: MAILER_HOST, token: user.token)

      resp = RestClient.post "#{API_BASE_URL}/messages",
                             :from => 'Ginnie Admin <admin@ginnielabs.in>',
                             :to => user.email,
                             :subject => 'Activate your account',
                             :text => "Welcome #{user.name}, Please activate your account by clicking this #{activation_url}"

    end
  end

  private
  def self.is_email_suppressed?(email)
    bounced?(email) && complained?(email) && unsubscribed?(email)
  end

  def self.bounced?(email)
    resp = RestClient.get("#{API_BASE_URL}/bounces/#{email}") { |response, request, result| response }
    # If email in bounce list, it'll respond with code 200 else 404
    resp.code == 200
  end

  def self.complained?(email)
    resp = RestClient.get("#{API_BASE_URL}/complaints/#{email}") { |response, request, result| response }
    # If email in bounce list, it'll respond with code 200 else 404
    resp.code == 200
  end

  def self.unsubscribed?(email)
    resp = RestClient.get("#{API_BASE_URL}/unsubscribes/#{email}") { |response, request, result| response }
    # If email in bounce list, it'll respond with code 200 else 404
    resp.code == 200
  end

end
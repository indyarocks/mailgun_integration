class MailgunWebhookController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :validate_request_source

  def message_open
    response = MailgunWebhookService.register_open(
        mailgun_id: open_params['message-id'],
        ip_address: open_params['ip']
    )
    status = response[:error].blank? ? 200 : 422
    render json: response, status: status
  end

  def message_click
    response = MailgunWebhookService.register_event(
        mailgun_id: click_params['message-id'],
        event: click_params['event'],
        ip_address: click_params['ip'],
        email: click_params['recipient']
    )
    status = response[:error].blank? ? 200 : 422
    render json: response, status: status
  end

  def message_bounce
    response = MailgunWebhookService.register_event(
        mailgun_id: bounce_params['Message-Id'].to_s.gsub(/^<|>$/, ''), # Test webhook have different key here
        event: bounce_params['event'],
        data: {
            ip: bounce_params['ip']
        },
        email: click_params['recipient']
    )
    status = response[:error].blank? ? 200 : 422
    render json: response, status: status
  end

  private
  def open_params
    # {
    #     "city"=>"Mountain View",
    #     "domain"=>"ginnielabs.in",
    #     "device-type"=>"desktop",
    #     "client-type"=>"browser",
    #     "h"=>"6973b0199a84ae81eb4ce3bd57b75193",
    #     "region"=>"CA",
    #     "client-name"=>"Firefox",
    #     "user-agent"=>"Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko Firefox/11.0 (via ggpht.com GoogleImageProxy)",
    #     "country"=>"US",
    #     "client-os"=>"Windows",
    #     "ip"=>"66.249.84.207",
    #     "message-id"=>"20161214184323.9765.3791.04C62074@ginnielabs.in",
    #     "recipient"=>"chandan.jhun@gmail.com",
    #     "event"=>"opened",
    #     "timestamp"=>"1481741016",
    #     "token"=>"38656dec1c49200c9df449bbf2bfe648fe49a78b2ac95d403e",
    #     "signature"=>"90f658a9cff1a5d6e2c9e86a09eb67b298ef169a3f0ec81eefd8c6671d34bf2a",
    #     "body-plain"=>"",
    #     "controller"=>"mailgun_webhook",
    #     "action"=>"message_open"
    # }
    params.permit(:ip, 'message-id', :recipient, :event, :timestamp, :token, :signature)
  end

  def click_params
    params.permit(:ip, 'message-id', :recipient, :event, :timestamp, :token, :signature)
  end

  def bounce_params
    params.permit(:ip, 'Message-Id', :recipient, :event, :timestamp, :token, :signature)
  end


  def validate_request_source
    data = params[:timestamp].to_s + params[:token].to_s
    key = Rails.application.secrets['mailgun_api_key']
    secure_signature = OpenSSL::HMAC.hexdigest('SHA256', key, data)
    unless secure_signature == params[:signature]
      render json: {
          message: 'Invalid Request'
      }, status: :forbidden and return
    end
  end
end

class MailgunWebhookService < ApplicationService
  require 'tempfile'
  require 'csv'

  def self.register_open(mailgun_id:, ip_address:)
    message = Message.find_by(mailgun_id: mailgun_id)
    return {
        error: 'Invalid message id.'
    } if message.blank?

    event = message.mailgun_events.new(
        event: :opened,
        ip_address: ip_address
    )
    if event.save
      return {
          error: ''
      }
    else
      return {
          error: event.errors.full_messages
      }
    end
  end

  def self.register_event(mailgun_id: , event: , ip_address:, email:)
    message = Message.find_by(mailgun_id: mailgun_id)
    return {
      error: 'Invalid message id.'
    } if message.blank?

    temp_file = Tempfile.new("#{Time.now.to_i}_#{event}.csv", Rails.root.join('tmp'))
    csv_file = CSV.open(temp_file, 'w') do |csv|
      csv << [
          email, ip_address, message.subject, event
      ]
    end
    event = message.mailgun_events.new(
        event: event,
        ip_address: ip_address
    )
    if event.save
      return {
          error: ''
      }
    else
      return {
          error: event.errors.full_messages
      }
    end
  end
end
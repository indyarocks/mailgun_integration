class MailgunWebhookService < ApplicationService

  def self.register_open(mailgun_id:, data:)
    message = Message.find_by(mailgun_id: mailgun_id)
    return {
        error: 'Invalid message id.'
    } if message.blank?

    event = message.mailgun_events.new(
        event: :opened,
        data: data
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

  def self.register_event(mailgun_id: , event: , data:, email:)
    message = Message.find_by(mailgun_id: mailgun_id)
    return {
      error: 'Invalid message id.',
      file: ''
    } if message.blank?

    csv_file = CSV.generate do |csv|
      csv << [
          email, data[:ip], message.subject, event
      ]
    end
    event = message.mailgun_events.new(
        event: event,
        data: data
    )
    if event.save
      return {
          error: '',
          file: csv_file
      }
    else
      return {
          error: event.errors.full_messages,
          file: csv_file
      }
    end
  end
end
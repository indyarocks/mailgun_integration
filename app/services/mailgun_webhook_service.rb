class MailgunWebhookService < ApplicationService

  def self.register_event(mailgun_id: , event: , data:)
    message = Message.find_by(mailgun_id: mailgun_id)
    return {
      error: 'Invalid message id.'
    }
    event = message.mailgun_events.new(
        event: event,
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
end
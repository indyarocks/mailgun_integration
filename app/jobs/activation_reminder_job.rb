class ActivationReminderJob < ApplicationJob
  queue_as :default

  def perform
    # TODO Query Optimization later
    pending_users = User.where(
        'activated_at IS NULL AND invited_at >=',
        Date.today - 2.days
    ).
        includes(messages: [:mailgun_events]).
        where('messages.message_type = ?', Message.message_types[:activation]).
        references(:messages)

    pending_users.each do |user|
      next if user.messages.activation.where('mailgun_events.event = ?', MailgunEvent.events[:opened]).first

    end
    if user.present?
      begin
        MailgunService.send_activation_email(user)
      rescue Exception => ex
        Rails.logger.debug("EXCEPTION RAISED: Mailgun mail failed: Message: #{ex.message}\n\n Backtrace: #{ex.backtrace}\n\n")
      end
    end
  end
end

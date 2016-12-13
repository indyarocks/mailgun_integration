class UserActivationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    if user.present?
      begin
        MailgunService.new.send_email(user)
      rescue Exception => ex
        Rails.logger.debug("EXCEPTION RAISED: Mailgun mail failed: Message: #{ex.message}\n\n Backtrace: #{ex.backtrace}\n\n")
      end
    end
  end
end

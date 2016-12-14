# == Schema Information
#
# Table name: mailgun_events
#
#  id         :integer          not null, primary key
#  message_id :integer          not null
#  event      :integer          not null
#  data       :jsonb            default("{}"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MailgunEvent < ApplicationRecord
  belongs_to :message
  validates_presence_of :message, :event

  enum event: {
      opened: 1,
      clicked: 2,
      bounced: 3
  }

end

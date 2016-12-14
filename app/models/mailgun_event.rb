class MailgunEvent < ApplicationRecord
  serialize :data, HashSerializer

  belongs_to :message
  validates_presence_of :message, :event

  enum event: {
      opened: 1,
      clicked: 2,
      bounced: 3
  }

end

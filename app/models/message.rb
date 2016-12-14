class Message < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  has_many :mailgun_events

  validates_presence_of :recipient, :message_type

  enum message_type: {
      default: 0,
      activation: 1,
      reminder: 2
  }
end

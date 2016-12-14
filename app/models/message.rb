class Message < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :mailgun_events

  validates_presence_of :user, :message_type

  enum message_type: {
      default: 0,
      activation: 1,
      reminder: 2
  }
end

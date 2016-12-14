# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  mailgun_id   :citext
#  message_type :integer          default("0"), not null
#  subject      :citext
#  content      :citext
#  opened_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

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

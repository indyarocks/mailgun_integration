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

require 'rails_helper'

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

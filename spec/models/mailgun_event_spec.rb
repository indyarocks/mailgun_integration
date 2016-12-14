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

require 'rails_helper'

RSpec.describe MailgunEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

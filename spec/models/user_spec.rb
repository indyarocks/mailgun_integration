# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :citext           not null
#  email            :citext           not null
#  token            :string           not null
#  is_suppressed    :boolean          default("false"), not null
#  invited_at       :datetime         not null
#  reminder_sent_at :datetime
#  activated_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

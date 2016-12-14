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

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/, case_sensitive: false
  before_create :generate_token
  has_many :messages

  private
    def generate_token
      loop do
        token = SecureRandom.hex(25)
        unless User.where(token: token).first
          self.token = token
          self.invited_at = Time.current
          break
        end
      end
    end
end

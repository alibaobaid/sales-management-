# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  is_default      :boolean          default(FALSE)
#  password_digest :string           not null
#  role_type       :string           default("مدير"), not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  country_id      :bigint(8)
#
# Indexes
#
#  index_users_on_country_id       (country_id)
#  index_users_on_password_digest  (password_digest)
#  index_users_on_role_type        (role_type)
#  index_users_on_username         (username)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class User < ApplicationRecord

  has_secure_password

  # assosiations
  has_many :access_tokens
  belongs_to :country

  # Validations
  validates :username, presence: true, uniqueness: { scope: [:country_id] }
  validates :role_type, inclusion: { in: ['مدير', 'مستخدم'] }

  # Callback
  before_destroy :can_not_destroy_default, if: :is_default?

  def generate_token
    token = access_tokens.create(value: SecureRandom.hex)
    token.value
  end


  private

  def can_not_destroy_default
    errors.add(:base, 'لا يمكنك حذف الحساب الافتراضي')
    throw(:abort)
  end
end

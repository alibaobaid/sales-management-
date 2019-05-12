# == Schema Information
#
# Table name: manger_discounts
#
#  id               :bigint(8)        not null, primary key
#  Desc             :string
#  date_of_discount :date
#  value            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  manger_id        :bigint(8)
#
# Indexes
#
#  index_manger_discounts_on_manger_id  (manger_id)
#
# Foreign Keys
#
#  fk_rails_...  (manger_id => mangers.id)
#

class MangerDiscount < ApplicationRecord
  # Associations
  belongs_to :manger

  # Validations
  validates :value,
            :date_of_discount,
             presence: true

  # Callbacks
  after_create :update_manger_account

  def update_manger_account
    manger.update(to_him: manger.to_him.to_i - value)
  end
end

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
#  country_id       :bigint(8)
#  manger_id        :bigint(8)
#
# Indexes
#
#  index_manger_discounts_on_country_id  (country_id)
#  index_manger_discounts_on_manger_id   (manger_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#  fk_rails_...  (manger_id => mangers.id)
#

class MangerDiscount < ApplicationRecord
  # Associations
  belongs_to :manger
  belongs_to :country

  # Validations
  validates :value,
            :date_of_discount,
             presence: true

  # Callbacks
  after_create :update_manger_account
  after_update :update_manger_account_changes, if: :saved_change_to_value?
  after_destroy :reverse_changes

  def update_manger_account
    manger.update(to_him: manger.to_him.to_i - value)
    manger.update(for_him: manger.for_him.to_i - value)
  end

  def update_manger_account_changes
    manger.update(to_him: manger.to_him.to_i + value_before_last_save)
    manger.update(for_him: manger.for_him.to_i + value_before_last_save)
    manger.update(to_him: manger.to_him.to_i - value)
    manger.update(for_him: manger.for_him.to_i - value)
  end

  def reverse_changes
    manger.update(to_him: manger.to_him.to_i + value)
    manger.update(for_him: manger.for_him.to_i + value)
  end  
end

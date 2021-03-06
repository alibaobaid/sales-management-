# == Schema Information
#
# Table name: manger_discounts
#
#  id               :bigint(8)        not null, primary key
#  Desc             :string
#  date_of_discount :date
#  value            :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  country_id       :bigint(8)
#  manger_id        :bigint(8)
#  bank_id        :bigint(8)
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
  belongs_to :bank


  # Validations
  validates :value,
            :date_of_discount,
             presence: true

  # Callbacks
  after_create :update_manger_and_bank_account
  after_update :update_manger_and_bank_account_changes, if: :saved_change_to_value?
  after_destroy :reverse_changes

  def update_manger_and_bank_account
    manger.update(for_him: manger.for_him.to_f - value)
    manger.update(to_him: manger.to_him.to_f - value)
    manger.update(final_manager_amount: manger.final_manager_amount.to_f - value)
    bank.update(balance: bank.balance.to_f - value) if bank.present?
  end

  def update_manger_and_bank_account_changes
    manger.update(for_him: manger.for_him.to_f + value_before_last_save)
    manger.update(to_him: manger.to_him.to_f + value_before_last_save)
    manger.update(final_manager_amount: manger.final_manager_amount.to_f + value_before_last_save)
    bank.update(balance: bank.balance.to_f + value_before_last_save) if bank.present?
    manger.update(for_him: manger.for_him.to_f - value)
    manger.update(to_him: manger.to_him.to_f - value)
    manger.update(final_manager_amount: manger.final_manager_amount.to_f - value)
    bank.update(balance: bank.balance.to_f - value) if bank.present?
  end

  def reverse_changes
    manger.update(for_him: manger.for_him.to_f + value)
    manger.update(to_him: manger.to_him.to_f + value)
    manger.update(final_manager_amount: manger.final_manager_amount.to_f + value)
    bank.update(balance: bank.balance.to_f + value) if bank.present?
  end
end

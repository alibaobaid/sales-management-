# == Schema Information
#
# Table name: bank_transfers
#
#  id               :bigint(8)        not null, primary key
#  date_of_transfer :datetime
#  note             :string
#  price            :float
#  section_type     :string
#  transfer_type    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  assistant_id     :bigint(8)
#  bank_id          :bigint(8)
#  country_id       :bigint(8)
#  delegate_id      :bigint(8)
#  manger_id        :bigint(8)
#  marketer_id      :bigint(8)
#
# Indexes
#
#  index_bank_transfers_on_assistant_id  (assistant_id)
#  index_bank_transfers_on_bank_id       (bank_id)
#  index_bank_transfers_on_country_id    (country_id)
#  index_bank_transfers_on_delegate_id   (delegate_id)
#  index_bank_transfers_on_manger_id     (manger_id)
#  index_bank_transfers_on_marketer_id   (marketer_id)
#
# Foreign Keys
#
#  fk_rails_...  (assistant_id => assistants.id)
#  fk_rails_...  (bank_id => banks.id)
#  fk_rails_...  (country_id => countries.id)
#  fk_rails_...  (delegate_id => delegates.id)
#  fk_rails_...  (manger_id => mangers.id)
#  fk_rails_...  (marketer_id => marketers.id)
#

class BankTransfer < ApplicationRecord

  # Associations
  belongs_to :delegate , optional: true
  belongs_to :marketer , optional: true
  belongs_to :assistant , optional: true
  belongs_to :manger, optional: true
  belongs_to :country
  belongs_to :bank


  # Validations
  validates :date_of_transfer,
            :transfer_type,
            :section_type,
            :price,
            presence: true
  validate :not_updatable_fields, on: :update

  # Callbacks
  after_create :update_price_of_employee
  after_update :update_price_of_employee_changes, if: :saved_change_to_price?
  after_update :update_bank_and_manager, if: :saved_change_to_price?
  after_destroy :reverse_operation

  # Scopes
  scope :on_date, -> (date) { where(date_of_transfer: date) }
  scope :between, -> (from, to) { where(date_of_transfer: from..to) }
  scope :delegate, -> (id) { where(delegate_id: id) }
  scope :marketer, -> (id) { where(marketer_id: id) }
  scope :receipt_type, -> { where(transfer_type: 'استلام') }
  
  def update_price_of_employee
    if transfer_type == "ارسال"
      add_price_to_bank_and_manger
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f + price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f + price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f + price)
      end
    elsif transfer_type == "استلام"
      remove_price_from_bank_and_manger
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f - price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f - price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f - price)
      end
    end
  end


  def reverse_operation
    if transfer_type == "استلام"
      add_price_to_bank_and_manger
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f + price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f + price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f + price)
      end
    elsif transfer_type == "ارسال"
      remove_price_from_bank_and_manger
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f - price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f - price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f - price)
      end
    end
  end

  def not_updatable_fields
      errors.add(:base,'لا يمكن حفظ البيانات التي قمت بتعديله') and throw(:abort) if not_allowed_changes?
  end

  def not_allowed_changes?
    delegate_id_changed? || marketer_id_changed? || section_type_changed? || transfer_type_changed?
  end

  def update_price_of_employee_changes
    if transfer_type == "ارسال"
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f - price_before_last_save)
        delegate.update(for_him: delegate.for_him.to_f + price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f - price_before_last_save)
        marketer.update(for_him: marketer.for_him.to_f + price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f - price_before_last_save)
        assistant.update(for_him: assistant.for_him.to_f + price)
      end
    elsif transfer_type == "استلام"
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_f + price_before_last_save)
        delegate.update(for_him: delegate.for_him.to_f - price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_f + price_before_last_save)
        marketer.update(for_him: marketer.for_him.to_f - price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_f + price_before_last_save)
        assistant.update(for_him: assistant.for_him.to_f - price)
      end
    end
  end
  
  def add_price_to_bank_and_manger
    default_manger = Manger.where(country_id: self.country_id).first
    bank.update(balance: bank.balance.to_f + price) if bank.present?
    default_manger.update(to_him: default_manger.to_him.to_f + price)
  end

  def remove_price_from_bank_and_manger
    default_manger = Manger.where(country_id: self.country_id).first
    bank.update(balance: bank.balance.to_f - price) if bank.present?
    default_manger.update(to_him: default_manger.to_him.to_f - price)
  end

  def update_bank_and_manager
    default_manger = Manger.where(country_id: self.country_id).first
    if transfer_type == "ارسال"
      default_manger.update(to_him: default_manger.to_him.to_f - price_before_last_save)
      default_manger.update(to_him: default_manger.to_him.to_f + price)
      bank.update(balance: bank.balance.to_f - price_before_last_save) if bank.present?
      bank.update(balance: bank.balance.to_f + price) if bank.present?
    else
      default_manger.update(to_him: default_manger.to_him.to_f + price_before_last_save)
      default_manger.update(to_him: default_manger.to_him.to_f - price)
      bank.update(balance: bank.balance.to_f + price_before_last_save) if bank.present?
      bank.update(balance: bank.balance.to_f - price) if bank.present?
    end
  end
end

# == Schema Information
#
# Table name: bank_transfers
#
#  id               :bigint(8)        not null, primary key
#  date_of_transfer :datetime
#  price            :integer
#  section_type     :string
#  transfer_type    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  assistant_id     :bigint(8)
#  delegate_id      :bigint(8)
#  manger_id        :bigint(8)
#  marketer_id      :bigint(8)
#
# Indexes
#
#  index_bank_transfers_on_assistant_id  (assistant_id)
#  index_bank_transfers_on_delegate_id   (delegate_id)
#  index_bank_transfers_on_manger_id     (manger_id)
#  index_bank_transfers_on_marketer_id   (marketer_id)
#
# Foreign Keys
#
#  fk_rails_...  (assistant_id => assistants.id)
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

  # Validations
  validates :date_of_transfer,
            :transfer_type,
            :section_type,
            :price,
            presence: true

  # Callbacks
  after_create :update__price_of_employee

  def update__price_of_employee

    if transfer_type == "ارسال" 
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_i + price)
      elsif section_type == "مدير"
        manger.update(to_him: manger.to_him.to_i - price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_i + price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_i + price)
      end
    elsif transfer_type == "استلام"
      if section_type == "مندوب"
        delegate.update(for_him: delegate.for_him.to_i - price)
      elsif section_type == "مدير"
        manger.update(to_him: manger.to_him.to_i + price)
      elsif section_type == "مسوق"
        marketer.update(for_him: marketer.for_him.to_i - price)
      elsif section_type == "مساعد"
        assistant.update(for_him: assistant.for_him.to_i - price)
      end
    end
  end

end

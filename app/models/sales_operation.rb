# == Schema Information
#
# Table name: sales_operations
#
#  id                  :bigint(8)        not null, primary key
#  commodity_amount    :integer          not null
#  commodity_type      :string           not null
#  date                :date             not null
#  delegate_commission :float            not null
#  marketer_commission :float            not null
#  price               :float            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  delegate_id         :bigint(8)        not null
#  marketer_id         :bigint(8)        not null
#
# Indexes
#
#  index_sales_operations_on_delegate_id  (delegate_id)
#  index_sales_operations_on_marketer_id  (marketer_id)
#
# Foreign Keys
#
#  fk_rails_...  (delegate_id => delegates.id)
#  fk_rails_...  (marketer_id => marketers.id)
#

class SalesOperation < ApplicationRecord
  belongs_to :delegate
  belongs_to :marketer

  validates :commodity_amount, 
            :commodity_type,
            :date,
            :delegate_commission,
            :marketer_commission,
            :price ,
            :delegate_id,
            :marketer_id,
            presence: true

  def manager_commission
    price - delegate_commission - marketer_commission
  end
end

# == Schema Information
#
# Table name: mangers
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :integer
#  name       :string
#  phone_NO   :string
#  to_him     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Manger < ApplicationRecord

  # Validations
  validates :name,  presence: true

  # Callback
  before_create :default_one_account


  private

  def default_one_account
    errors.add(:base, 'لايمكن اضافة حساب اخر') if Manger.any?
  end

end

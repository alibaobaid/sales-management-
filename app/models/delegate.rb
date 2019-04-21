# == Schema Information
#
# Table name: delegates
#
#  id               :bigint(8)        not null, primary key
#  amount_of_box    :integer
#  amount_of_gallon :integer
#  city             :string
#  for_him          :integer
#  name             :string
#  phone_NO         :string
#  to_him           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Delegate < ApplicationRecord

    # Associations
    has_many   :deliveries, dependent: :destroy, inverse_of: :delegate

    # Validations
    validates :name, :city, presence: true

end

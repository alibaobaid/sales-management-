
class ExternalEmployee < ApplicationRecord

  # Associations
  has_many :external_transfers, as: :sender, dependent: :destroy
  has_many :external_transfers, as: :receiver, dependent: :destroy
  belongs_to :country
  # Validations
  validates :name, presence: true, uniqueness: { scope: [:country_id] }
end

class ExternalTransfer < ApplicationRecord

  # Associations
  belongs_to :sender , polymorphic: true
  belongs_to :receiver , polymorphic: true
  belongs_to :country


  # Validations
  validates :date_of_transfer, :price, presence: true

  # Scopes
  scope :on_date, -> (date) { where(date_of_transfer: date) }
  scope :between, -> (from, to) { where(date_of_transfer: from..to) }

end

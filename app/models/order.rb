class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  enum status: { pending: 0, delivered: 5, canceled: 9 }

  validates :code, :expected_delivery_date, presence: true
  validate :expected_delivery_date_is_future

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def expected_delivery_date_is_future
    if self.expected_delivery_date.present? && self.expected_delivery_date <= Date.today
      self.errors.add(:expected_delivery_date, 'date must be in the future')
    end
  end
end

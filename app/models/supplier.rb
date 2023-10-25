class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :nif, :address, :city, :state, :email, presence: true
  validates :nif, uniqueness: true
end

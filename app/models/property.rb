  class Property < ApplicationRecord
  belongs_to :property_location
  belongs_to :property_owner

  has_many :price_ranges
  has_many :proposals

  validates :title, :maximum_guests, :minimum_rent, :maximum_rent, :daily_rate,
    :rent_purpose, :main_photo, :description, :neighborhood, :rooms, presence: {
      message: 'É necessário preencher todos os dados do imóvel' }
end

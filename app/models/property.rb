  class Property < ApplicationRecord
  has_attached_file :main_photo, styles: {thumb: '100X100', medium: '300x300'}

  belongs_to :property_location
  belongs_to :property_owner

  has_many :price_ranges
  has_many :proposals

  validates :main_photo, attachment_presence: true
  validates_attachment_content_type :main_photo, content_type: /\Aimage\/.*\z/
  validates :title, :maximum_guests, :minimum_rent, :maximum_rent, :daily_rate,
    :rent_purpose, :description, :neighborhood, :rooms, presence: {
      message: 'É necessário preencher todos os dados do imóvel' }
end

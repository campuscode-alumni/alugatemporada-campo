class Property < ApplicationRecord
  belongs_to :property_location
  has_many :proposals
end

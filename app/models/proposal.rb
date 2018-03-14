class Proposal < ApplicationRecord
  belongs_to :property
  validates :name, :email, :phone,
            :rent_purpose, :total_guest,
            :start_date, :end_date, presence: true
end

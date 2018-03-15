class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  validates :rent_purpose, :total_guest,
            :start_date, :end_date, presence: true
end

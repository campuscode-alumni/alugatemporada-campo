class Proposal < ApplicationRecord
  belongs_to :property
  validates :name, :email, :phone,
            :rent_purpose, :total_guest,
            :start_date, :end_date, presence: true

  before_save :calculate_total_amount

  private
  def calculate_total_amount
    days = (end_date - start_date).to_i
    self.total_amount = days * self.property.daily_rate
  end
end

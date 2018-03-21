class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  validates :rent_purpose, :total_guest,
            :start_date, :end_date, presence: true

  enum status: [:pending, :accepted, :rejected]
  before_save :calculate_total_amount

  private

  def calculate_total_amount
    sum = 0
    days = (start_date..end_date).to_a.length

    (start_date..end_date).each do |day|
      unless property.price_ranges.empty?
        property.price_ranges.each do |range|
          if (range.start_date.to_date..range.end_date.to_date).to_a.include? day.to_date
            sum = sum + range.daily_rate
            days = days - 1
          end
        end
      end
    end

    sum = sum + days * property.daily_rate
    self.total_amount = sum
  end
end

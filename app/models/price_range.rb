class PriceRange < ApplicationRecord
  belongs_to :property
  validates :description, :start_date, :end_date, :daily_rate,
      presence: { message: 'É necessário preencher todos os dados da temporada'}

  validate :final_date_is_greater_than_start_date, on: :create

  def final_date_is_greater_than_start_date
    if start_date && end_date && start_date > end_date
      errors[:base] << 'A data inicial não pode ser maior que a data final'
    end
  end
end

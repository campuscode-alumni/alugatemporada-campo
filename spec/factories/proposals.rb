FactoryBot.define do
  factory :proposal do
    rent_purpose "Férias com a família"
    total_guest 8
    start_date "2018-03-08"
    end_date "2018-03-08"
    pet true
    smoker false
    total_amount "199.99"
    details "Detalhes da proposta"
    property
    user
  end
end

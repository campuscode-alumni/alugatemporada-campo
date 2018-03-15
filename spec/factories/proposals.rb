FactoryBot.define do
  factory :proposal do
    rent_purpose "Férias com a família"
    total_guest 8
    start_date "2018-12-01 23:26:34"
    end_date "2018-12-05 23:26:34"
    pet true
    smoker false
    details "Detalhes da proposta"
    property
    user
  end
end

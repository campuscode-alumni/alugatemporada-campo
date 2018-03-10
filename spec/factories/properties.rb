FactoryBot.define do
  factory :property do
    title 'Casa de Campo'
    description 'Uma linda casa em Campos de Jordão'
    neighborhood 'Campos'
    rent_purpose 'Férias'
    main_photo 'foto.jpg'
    rooms 5
    maximum_guests 15
    minimum_rent 3
    maximum_rent 15
    daily_rate 200.0
    accessibility true
    allow_pets false
    allow_smokers true

    property_location
    property_owner
  end
end

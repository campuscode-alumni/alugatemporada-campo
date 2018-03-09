FactoryBot.define do
  factory :property do
    title "Casa de Campo"
    description 'Uma casa especial para férias.'
    property_location
    neighborhood 'Vila da Galinha'
    main_photo 'foto.jpg'
    rent_purpose 'Férias'
    rooms 6
    accessibility true
    allow_pets true
    allow_smokers false
    maximum_guests 5
    minimum_rent 5
    maximum_rent 5
    daily_rate "199.99"
  end
end

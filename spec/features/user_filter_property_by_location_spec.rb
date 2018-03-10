require 'rails_helper'

feature 'User filter by' do
  scenario 'valid location' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Campos do Jordão')
    create_properties('Casa de fazenda', local, owner)

    visit root_path

    select 'Campos do Jordão', from: 'Localização'
    click_on 'Filtrar'

    expect(page).to have_css('h1', text: 'Casa de fazenda')
    expect(page).to have_css('p', text: 'Localização: Campos do Jordão')
    expect(page).to have_css('p', text: 'Número máximo de hospedes: 10')
    expect(page).to have_css('p', text: 'Valor base: 200')
    expect(page).to have_css('h3', text: 'casa_de_campo.jpg')
  end

  scenario 'invalid location' do
    owner = create(:property_owner)
    PropertyLocation.create(name: 'Campos dos Goitacases')
    local = PropertyLocation.create(name: 'Campos do Jordão')
    prop = create_properties('Casa de fazenda', local, owner)

    visit root_path

    select 'Campos dos Goitacases', from: 'Localização'
    click_on 'Filtrar'

    expect(page).to have_content('Nenhum resultado encontrado')
  end

  def create_properties(title, local, owner)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200,
      maximum_guests: 10,
      property_location_id: local.id,
      description: 'Uma casa especial para férias.',
      neighborhood: 'Vila da Galinha',
      rent_purpose: 'Férias',
      rooms: 6,
      accessibility: true,
      allow_pets: true,
      allow_smokers: false,
      minimum_rent: 5,
      maximum_rent: 5,
      property_owner: owner
    )
  end
end

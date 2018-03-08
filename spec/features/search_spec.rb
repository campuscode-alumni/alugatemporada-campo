require 'rails_helper'

feature 'User filter by' do
  scenario 'valid location' do
    local = PropertyLocation.create(name: 'Campos do Jordão')
    create_properties('Casa de fazenda', local)

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
    PropertyLocation.create(name: 'Campos dos Goitacases')
    local = PropertyLocation.create(name: 'Campos do Jordão')
    prop = create_properties('Casa de fazenda', local)

    visit root_path

    select 'Campos dos Goitacases', from: 'Localização'
    click_on 'Filtrar'

    expect(page).to have_content('Nenhum resultado encontrado')
  end

  def create_properties(title, local)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200,
      maximum_guests: 10,
      property_location_id: local.id
    )
  end
end

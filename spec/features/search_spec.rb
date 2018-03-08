require 'rails_helper'

feature 'User filter by' do
  scenario 'valid location' do
    prop = create_properties('Casa de fazenda')
    #local = Location.create(name: 'Campos de Jordão')

    visit root_path

    fill_in 'Localização', with: 'Campos de Jordão'
    click_on 'Filtrar'

    expect(page).to have_css('h1', text: 'Casa de fazenda')
    expect(page).to have_css('p', text: 'Localização: Campos de Jordão')
    expect(page).to have_css('p', text: 'Número máximo de hospedes: 10')
    expect(page).to have_css('p', text: 'Valor base: 200')
    expect(page).to have_css('h3', text: 'casa_de_campo.jpg')
  end

  scenario 'invalid location' do
    prop = create_properties('Casa de fazenda')

    visit root_path

    fill_in 'Localização', with: 'Campos dos Goitacases'
    click_on 'Filtrar'

    expect(page).to have_css('h1', text: 'Nenhum resultado encontrado')
  end

  def create_properties(title)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200,
      maximum_guests: 10,
      property_location: 'Campos de Jordão'
    )
  end
end

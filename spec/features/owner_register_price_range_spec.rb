require "rails_helper"

feature 'Owner register a price range in a property' do
  scenario 'successfuly' do
    local = PropertyLocation.create(name: 'Campos do Jordão')
    property = Property.create(
                title: 'Casa de Campo',
                description: 'Uma linda casa em Campos de Jordão',
                property_location: local,
                neighborhood: 'Campos',
                rent_purpose: 'Férias',
                main_photo: 'foto.jpg',
                rooms: 5,
                maximum_guests: 15,
                minimum_rent: 3,
                maximum_rent: 15,
                daily_rate: 200.0,
                accessibility: true,
                allow_pets: false,
                allow_smokers: true,
              )

    visit property_path(property)
    click_on 'Cadastrar uma temporada'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Data inicial', with: '01/02/2018'
    fill_in 'Data final', with: '05/02/2018'
    fill_in 'Preço da diária', with: '1000.0'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: 'Preços por temporada')
    expect(page).to have_css('h4', text: 'Carnaval')
    expect(page).to have_css('li', text: 'Data inicial: 01/02/2018')
    expect(page).to have_css('li', text: 'Data final: 05/02/2018')
    expect(page).to have_css('li', text: 'Preço da diária: R$ 1000.0')
    expect(current_path).to eq(property_path(property))
  end
end

require 'rails_helper'

feature 'Owner login' do
  scenario 'successfuly' do
    owner = PropertyOwner.create(email: 'property@owner.com', password: '12345678')
    local = PropertyLocation.create(name: 'Santos')
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
                property_owner: owner
              )

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'property@owner.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(current_path).to eq(property_owner_properties_path(owner))
    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('p', text: property.property_location.name)
    expect(page).to have_css('p', text: property.maximum_guests)
    expect(page).to have_css('p', text: property.daily_rate)
    expect(page).to have_css('h3', text: property.main_photo)
    expect(page).to have_link('Ver mais detalhes', href: property_owner_property_path(owner, property))
  end

  scenario 'wrong email' do
    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'owner@property.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(current_path).to eq(new_property_owner_session_path)
    expect(page).to have_content('Invalid Email or password')
  end
end

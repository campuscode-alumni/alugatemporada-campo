require 'rails_helper'

feature 'User vist home#index' do
  scenario 'see last 10' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Santos')
    prop1 = create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    create_properties('Casa de campo', local, owner)
    prop2 = create_properties('Old', local, owner)

    visit root_path

    expect(page).to have_css('h1', text: prop1.title)
    expect(page).to_not have_css('h1', text: prop2.title)
  end

  scenario 'no results' do
    visit root_path

    expect(page).to have_content("Não existe nenhum
                      imóvel cadastrado no momento")
  end

  scenario 'see one property' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Santos')
    prop = create_properties('Casa de campo', local, owner)

    visit root_path

    expect(page).to have_css('h1', text: prop.title)
    expect(page).to have_css('p', text: prop.property_location.name)
    expect(page).to have_css('p', text: prop.maximum_guests)
    expect(page).to have_css('p', text: prop.daily_rate)
    expect(page).to have_css('h3', text: prop.main_photo)
    expect(page).to have_link('Ver mais detalhes', href: property_path(prop))
  end

  def create_properties(title, local, owner)
    Property.create(
      title: title,
      main_photo: 'casa_de_campo.jpg',
      property_location: local,
      description: 'Uma casa especial para férias.',
      neighborhood: 'Vila da Galinha',
      rent_purpose: 'Férias',
      rooms: 6,
      accessibility: true,
      allow_pets: true,
      allow_smokers: false,
      maximum_guests: 5,
      minimum_rent: 5,
      maximum_rent: 5,
      daily_rate: 199.99,
      property_owner: owner

    )
  end

end

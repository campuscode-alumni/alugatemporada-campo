require 'rails_helper'

feature 'User vist home#index' do
  scenario 'see last 10' do
    local = PropertyLocation.create(name: 'Santos')
    prop1 = create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    create_properties('Casa de campo', local)
    prop2 = create_properties('Old', local)

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
    local = PropertyLocation.create(name: 'Santos')
    prop = create_properties('Casa de campo', local)

    visit root_path

    expect(page).to have_css('h1', text: prop.title)
    expect(page).to have_css('p', text: prop.property_location.name)
    expect(page).to have_css('p', text: prop.maximum_guests)
    expect(page).to have_css('p', text: prop.daily_rate)
    expect(page).to have_css('h3', text: prop.main_photo)
    expect(page).to have_link('Ver mais detalhes', href: property_path(prop))
  end

  def create_properties(title, local)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200,
      maximum_guests: 10,
      property_location: local
    )
  end
end

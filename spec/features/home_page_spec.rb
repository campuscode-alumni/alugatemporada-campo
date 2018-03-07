require 'rails_helper'

feature 'User vist home#index' do
  scenario 'see last 10' do
    prop1 = create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    create_properties('Casa de campo')
    prop2 = create_properties('Old')

    visit root_path

    expect(page).to have_css('h1', text: prop1.title)
    expect(page).to_not have_css('h1', text: prop2.title)
  end

  scenario 'no results' do
    visit root_path

    expect(page).to have_content("Não existe nenhum
                      imóvel cadastrado no momento")

  end


  def create_properties(title)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200.00,
      maximum_guests: 1,
      property_location: 'Campos de Jordão'
    )
  end
end

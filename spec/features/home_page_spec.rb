require 'rails_helper'

feature 'User see last 10 properties' do
  scenario 'successfully' do
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

  def create_properties(title)
    Property.create(title: title,
      main_photo: 'casa_de_campo.jpg',
      daily_rate: 200.00,
      maximum_guests: 1,
      property_location: 'Campos de Jordão'
    )
  end
end

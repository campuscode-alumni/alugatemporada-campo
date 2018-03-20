require 'rails_helper'

feature 'User vist home#index' do
  scenario 'see last 10' do
    prop1 = create(:property, title: 'Casa de campo')
    owner = prop1.property_owner
    create_list(:property, 9, property_owner: owner)
    prop2 = create(:property, title: 'Old', property_owner: owner)

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
    prop = create(:property)

    visit root_path

    expect(page).to have_css('h1', text: prop.title)
    expect(page).to have_css('p', text: prop.property_location.name)
    expect(page).to have_css('p', text: prop.maximum_guests)
    expect(page).to have_css('p', text: prop.daily_rate)
    expect(page).to have_xpath("//img[contains(@src, 'casa_no_campo.jpg')]")
    expect(page).to have_link('Ver mais detalhes', href: property_path(prop))
  end
end

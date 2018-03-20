require 'rails_helper'

feature 'User filter by' do
  scenario 'valid location' do
    prop = create(:property)

    visit root_path

    select prop.property_location.name, from: 'Localização'
    click_on 'Filtrar'

    expect(page).to have_css('h1', text: prop.title)
    expect(page).to have_css('p', text: "Localização: #{prop.property_location.name}")
    expect(page).to have_css('p', text: "Número máximo de hospedes: #{prop.maximum_guests}")
    expect(page).to have_css('p', text: "Valor base: #{prop.daily_rate}")
    expect(page).to have_xpath("//img[contains(@src, 'casa_no_campo.jpg')]")
  end

  scenario 'invalid location' do
    prop = create(:property)
    local = create(:property_location, name: 'Porto dos porcos')

    visit root_path

    select local.name, from: 'Localização'
    click_on 'Filtrar'

    expect(page).to have_content('Nenhum resultado encontrado')
  end
end

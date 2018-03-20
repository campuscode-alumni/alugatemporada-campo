require 'rails_helper'

feature 'User view property details' do
  scenario 'successfuly' do
    property = create(:property)

    visit property_path(property)

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: "Descrição:")
    expect(page).to have_css('p',  text: property.description)
    expect(page).to have_css('li', text: "Localização: #{property.property_location.name}")
    expect(page).to have_css('li', text: "Bairro: #{property.neighborhood}")
    expect(page).to have_css('li', text: "Finalidade: #{property.rent_purpose}")
    expect(page).to have_xpath("//img[contains(@src, 'casa_no_campo.jpg')]")
    expect(page).to have_css('li', text: "Cômodos: #{property.rooms}")
    expect(page).to have_css('li', text: "Máximo de pessoas: #{property.maximum_guests}")
    expect(page).to have_css('li', text: "Mínimo de dias: #{property.minimum_rent}")
    expect(page).to have_css('li', text: "Máximo de dias: #{property.maximum_rent}")
    expect(page).to have_css('li', text: "Preço da diária: R$ #{property.daily_rate}")
    expect(page).to have_css('h3', text: "Condições permitidas:")
    expect(page).to have_css('li', text: 'Acessibilidade? Sim')
    expect(page).to have_css('li', text: 'Aceita animais? Não')
    expect(page).to have_css('li', text: 'Aceita fumantes? Sim')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and try to visit an invalid property' do
    visit property_path(-1)

    expect(current_path).to eq(root_path)
  end
end

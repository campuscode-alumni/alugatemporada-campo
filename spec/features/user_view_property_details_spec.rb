require 'rails_helper'

feature 'User can view property details' do
  scenario 'successfuly' do
    property = Property.create(
                title: 'Casa de Campo',
                description: 'Uma linda casa em Campos de Jordão',
                property_location: 'Campos de Jordão',
                neighborhood: 'Campos',
                rent_purpose: 'Férias',
                accessibility: true,
                allow_pets: false,
                allow_smokers: true,
                rooms: 5,
                maximum_guests: 15,
                minimum_rent: 3,
                maximum_rent: 15,
                daily_rate: 200.00
              )

    visit root_path
    click_on property.title

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: "Descrição:")
    expect(page).to have_css('p',  text: property.description)
    expect(page).to have_css('li', text: "Localização: #{property.property_location}")
    expect(page).to have_css('li', text: "Bairro: #{property.neighborhood}")
    expect(page).to have_css('li', text: "Finalidade: #{property.rent_purpose}")
    expect(page).to have_css('li', text: 'Acessibilidade? Sim')
    expect(page).to have_css('li', text: 'Aceita animais? Não')
    expect(page).to have_css('li', text: 'Aceita fumantes? Sim')
    expect(page).to have_css('li', text: "Cômodos: #{property.rooms}")
    expect(page).to have_css('li', text: "Máximo de pessoas: #{property.maximum_guests}")
    expect(page).to have_css('li', text: "Mínimo de dias: #{property.minimum_rent}")
    expect(page).to have_css('li', text: "Máximo de dias: #{property.maximum_rent}")
    expect(page).to have_css('li', text: "Preço da diária: R$ #{property.daily_rate}")
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario '' do
    # Forçar um link inválido
  end
end

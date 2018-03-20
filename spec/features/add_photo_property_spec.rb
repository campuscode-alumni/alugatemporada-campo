require 'rails_helper'

feature 'owner add a new photo for a property' do
  scenario 'successfuly' do
    property = create(:property)
    owner = property.property_owner
    local = property.property_location

    login_as(owner, scope: :property_owner)

    visit new_property_path(property)

    fill_in 'Título', with: 'Casa de Campo'
    fill_in 'Descrição', with: 'Uma casa especial para férias.'
    select local.name, from: 'Localização'
    fill_in 'Bairro', with: 'Vila da Galinha'
    fill_in 'Finalidade', with: 'Férias'
    fill_in 'Quantidade de cômodos', with: 6
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Máximo de pessoas', with: 12
    fill_in 'Mínimo de dias para locação', with: 3
    fill_in 'Máximo de dias para locação', with: 15
    fill_in 'Preço da diária', with: '250.00'
    attach_file('Foto principal', Rails.root + 'spec/support/casa_no_campo.jpg')
    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src, 'casa_no_campo.jpg')]")
  end
end

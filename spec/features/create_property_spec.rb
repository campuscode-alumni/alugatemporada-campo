require 'rails_helper'

feature 'User create property' do
  scenario 'successfully' do
    local = PropertyLocation.create(name: 'Porto de Galinhas')
    visit new_property_path

    fill_in 'Título', with: 'Casa de Campo'
    fill_in 'Descrição', with: 'Uma casa especial para férias.'
    select local.name, from: 'Localização'
    fill_in 'Bairro', with: 'Vila da Galinha'
    fill_in 'Foto principal', with: 'foto.jpg'
    fill_in 'Finalidade', with: 'Férias'
    fill_in 'Quantidade de cômodos', with: 6
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Máximo de pessoas', with: 12
    fill_in 'Mínimo de dias para locação', with: 3
    fill_in 'Máximo de dias para locação', with: 15
    fill_in 'Preço da diária', with: '250.00'
    click_on 'Enviar'

    expect(current_path).to eq property_path(1)
    expect(page).to have_css('h1', text: 'Cadastro de Imóvel')
    expect(page).to have_css('h1', text: 'Casa de Campo')
    expect(page).to have_css('h3', text: 'Descrição')
    expect(page).to have_css('p', text: 'Uma casa especial para férias.')
    expect(page).to have_css('li', text: "Localização: #{local.name}")
    expect(page).to have_css('li', text: 'Bairro: Vila da Galinha')
    expect(page).to have_css('li', text: 'Foto principal: foto.jpg')
    expect(page).to have_css('li', text: 'Cômodos: 6')
    expect(page).to have_css('li', text: 'Finalidade: Férias')
    expect(page).to have_css('li', text: 'Máximo de pessoas: 12')
    expect(page).to have_css('li', text: 'Mínimo de dias: 3')
    expect(page).to have_css('li', text: 'Máximo de dias: 15')
    expect(page).to have_css('h3', text: 'Condições permitidas:')
    expect(page).to have_css('li', text: 'Acessibilidade? Sim')
    expect(page).to have_css('li', text: 'Aceita animais? Sim')
    expect(page).to have_css('li', text: 'Aceita fumantes? Sim')
    expect(page).to have_css('li', text: 'Preço da diária: R$ 250')
    expect(page).to have_content('Voltar')
  end

  scenario 'fail' do
  end
end

require 'rails_helper'

feature 'Owner register property' do
  scenario 'successfully' do
    local = create(:property_location, name: 'Porto de Galinhas')
    owner = create(:property_owner, email: 'owner@property.com', password: '12345678')
    login_as(owner, scope: :property_owner)

    visit new_property_owner_property_path(owner)

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

    expect(current_path).to eq property_path(Property.last.id)
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

  scenario 'and must fill in all fields' do
    local = create(:property_location, name: 'Porto de Galinhas')
    owner = create(:property_owner, email: 'owner@property.com', password: '12345678')
    login_as(owner, scope: :property_owner)

    visit new_property_owner_property_path(owner)

    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    select local.name, from: 'Localização'
    fill_in 'Bairro', with: ''
    fill_in 'Foto principal', with: ''
    fill_in 'Finalidade', with: ''
    fill_in 'Quantidade de cômodos', with: ''
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Máximo de pessoas', with: ''
    fill_in 'Mínimo de dias para locação', with: ''
    fill_in 'Máximo de dias para locação', with: ''
    fill_in 'Preço da diária', with: ''
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os dados do imóvel')
  end

  scenario 'only logged in' do
    local = create(:property_location, name: 'Porto de Galinhas')
    owner = create(:property_owner, email: 'owner@property.com', password: '12345678')
    visit new_property_owner_property_path(owner)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(current_path).to eq(new_property_owner_session_path)
  end
end

require 'rails_helper'

feature 'user send a proposal' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Santos')
    property = Property.create(
                title: 'Casa de Campo',
                description: 'Uma linda casa em Campos de Jordão',
                property_location: local,
                neighborhood: 'Campos',
                rent_purpose: 'Férias',
                main_photo: 'foto.jpg',
                rooms: 5,
                maximum_guests: 15,
                minimum_rent: 3,
                maximum_rent: 15,
                daily_rate: 200.0,
                accessibility: true,
                allow_pets: false,
                allow_smokers: true,
                property_owner: owner
              )
    s_day = Date.today.strftime('%d/%m/%Y')
    e_day = (Date.today + 10.days).strftime('%d/%m/%Y')

    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Nome', with: 'Felix'
    fill_in 'Email', with: 'felix@email.com'
    fill_in 'Telefone', with: '121212-13131'
    fill_in 'Finalidade', with: 'Despedida de solteiro'
    fill_in 'Quantidade de hospedes', with: 12
    fill_in 'Data de entrada', with: s_day
    fill_in 'Data de saída', with:  e_day
    check 'Pretende levar pets?'
    check 'Fumante?'
    fill_in 'Mais informações', with: 'N/A'
    click_on 'Enviar'

    expect(current_path).to eq(property_path(property))
    expect(page).to have_content('Sua proposta foi enviada com sucesso!')
    expect(page).to have_css('li', text: 'Proponente: Felix')
    expect(page).to have_css('li', text: 'email do proponente: felix@email.com')
    expect(page).to have_css('li', text: 'Telefone do proponete: 121212-13131')
    expect(page).to have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to have_css('li', text: "estadia de #{s_day} até #{e_day}")
    expect(page).to have_css('li', text: 'Valor total da proposta: R$2000,00')
    expect(page).to have_css('li', text: 'Vou levar meu pet')
    expect(page).to have_css('li', text: 'Sou fumante')
    expect(page).to have_css('li', text: 'Maiores detalhes: N/A')
  end

  scenario 'with invalid params' do
    property = create(:property)
    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Finalidade', with: ''
    fill_in 'Quantidade de hospedes', with: ''
    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with:  ''
    check 'Pretende levar pets?'
    check 'Fumante?'
    fill_in 'Mais informações', with: 'N/A'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível envia sua proposta!')
    expect(page).to have_css('div', text: "Name can't be blank")
    expect(page).to have_css('div', text: "Email can't be blank")
    expect(page).to have_css('div', text: "Phone can't be blank")
    expect(page).to have_css('div', text: "Rent purpose can't be blank")
    expect(page).to have_css('div', text: "Total guest can't be blank")
    expect(page).to have_css('div', text: "Start date can't be blank")
    expect(page).to have_css('div', text: "End date can't be blank")
    expect(current_path).to eq(property_proposals_path(property))
  end
end

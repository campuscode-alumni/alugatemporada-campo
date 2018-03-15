require 'rails_helper'

feature 'user send a proposal' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Santos')
    property = create(:property, property_location: local, property_owner: owner)
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Finalidade', with: 'Despedida de solteiro'
    fill_in 'Quantidade de hospedes', with: 12
    fill_in 'Data de entrada', with: '21/11/2018'
    fill_in 'Data de saída', with:  '28/11/2018'
    check 'Pretende levar pets?'
    check 'Fumante?'
    fill_in 'Valor da proposta', with: 200.00
    fill_in 'Mais informações', with: 'N/A'
    click_on 'Enviar'

    expect(page).to have_content('Sua proposta foi enviada com sucesso!')
    expect(page).to have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to have_css('li', text: 'estadia de 21/11/2018 até 28/11/2018')
    expect(page).to have_css('li', text: 'Valor da proposta: 200.0' )
    expect(page).to have_css('li', text: 'Vou levar meu pet')
    expect(page).to have_css('li', text: 'Sou fumante')
    expect(page).to have_css('li', text: 'Maiores detalhes: N/A')
    expect(current_path).to eq(property_path(property))
  end

  scenario 'with invalid params' do
    property = create(:property)
    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Finalidade', with: ''
    fill_in 'Quantidade de hospedes', with: ''
    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with:  ''
    check 'Pretende levar pets?'
    check 'Fumante?'
    fill_in 'Valor da proposta', with: 200.00
    fill_in 'Mais informações', with: 'N/A'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível envia sua proposta!')
    expect(page).to have_css('div', text: "Rent purpose can't be blank")
    expect(page).to have_css('div', text: "Total guest can't be blank")
    expect(page).to have_css('div', text: "Start date can't be blank")
    expect(page).to have_css('div', text: "End date can't be blank")
    expect(current_path).to eq(property_proposals_path(property))
  end
end

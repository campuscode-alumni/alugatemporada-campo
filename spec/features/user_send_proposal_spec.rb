require 'rails_helper'

feature 'User send a proposal' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    local = PropertyLocation.create(name: 'Santos')
    start_day = Date.today.strftime('%d/%m/%Y')
    end_day = (Date.today + 10.days).strftime('%d/%m/%Y')
    property = create(:property, property_location: local, property_owner: owner)
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Finalidade', with: 'Despedida de solteiro'
    fill_in 'Quantidade de hospedes', with: 12
    fill_in 'Data de entrada', with: start_day
    fill_in 'Data de saída', with:  end_day
    check 'Pretende levar pets?'
    check 'Fumante?'
    fill_in 'Mais informações', with: 'N/A'
    click_on 'Enviar'

    expect(page).to have_content('Sua proposta foi enviada com sucesso!')
    expect(page).to have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to have_css('li', text: "Estadia de #{start_day} até #{end_day}")
    expect(page).to have_css('li', text: 'Valor total da proposta: R$2000,00')
    expect(page).to have_css('li', text: 'Vou levar meu pet')
    expect(page).to have_css('li', text: 'Sou fumante')
    expect(page).to have_css('li', text: 'Maiores detalhes: N/A')
    expect(current_path).to eq(property_path(property))
  end

  scenario 'with invalid params' do
    property = create(:property)
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver mais detalhes'
    click_on 'Enviar uma proposta'

    fill_in 'Finalidade', with: ''
    fill_in 'Quantidade de hospedes', with: ''
    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with:  ''
    check 'Pretende levar pets?'
    check 'Fumante?'
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

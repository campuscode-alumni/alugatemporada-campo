require 'rails_helper'

feature 'User can view your proposals' do
  scenario 'Login successfuly' do
    user = create(:user)

    visit root_path
    click_on 'Entrar como usuário'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Logar'

    expect(page).to have_content('Sair')
    expect(page).to have_link('Minhas propostas')
  end

  scenario 'successfuly' do
    user = create(:user)
    property = create(:property, title: 'Casa em Fortaleza')
    proposal = create(:proposal, user: user, property: property)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Minhas propostas'

    expect(page).to have_css('h1', text: 'Minhas propostas')
    expect(page).to have_content(property.title)
    expect(page).to have_content(property.property_location.name)
    expect(page).to have_content(proposal.start_date)
    expect(page).to have_content(proposal.end_date)
    expect(page).to have_content(proposal.total_amount)
    expect(page).to have_link('Sair')
    expect(page).to have_link('Voltar')
  end
end

require 'rails_helper'

feature 'User view your proposals' do
  scenario 'login successfuly' do
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
    expect(page).to have_css('h2', text: property.title)
    expect(page).to have_css('li', text: property.property_location.name)
    expect(page).to have_css('li', text: format_date(proposal.start_date))
    expect(page).to have_css('li', text: format_date(proposal.end_date))
    expect(page).to have_css('li', text: "R$800,00")

    expect(page).to have_link('Sair')
    expect(page).to have_link('Voltar')
  end

  scenario 'user can see only your proposal' do
    user_1 = create(:user, email: 'user1@email.com')
    user_2 = create(:user, email: 'user2@email.com')

    location_1 = create(:property_location, name: 'Fortaleza')
    location_2 = create(:property_location, name: 'Maceió')
    location_3 = create(:property_location, name: 'João Pessoa')
    property_owner = create(:property_owner)

    property_1 = create(:property, title: 'Casa em Fortaleza',
          property_location: location_1, property_owner: property_owner)
    property_2 = create(:property, title: 'Casa em Maceió',
          property_location: location_2, property_owner: property_owner)
    property_3 = create(:property, title: 'Casa em João Pessoa',
          property_location: location_3, property_owner: property_owner)

    proposal_1 = create(:proposal, user: user_1, property: property_1)
    proposal_2 = create(:proposal, user: user_1, property: property_2)
    proposal_3 = create(:proposal, user: user_2, property: property_3, end_date: '2018-12-06')

    login_as(user_1, scope: :user)
    visit root_path
    click_on 'Minhas propostas'

    expect(page).to have_css('h1', text: 'Minhas propostas')
    expect(page).to have_css('h2', text: property_1.title)
    expect(page).to have_css('li', text: property_1.property_location.name)
    expect(page).to have_css('li', text: format_date(proposal_1.start_date))
    expect(page).to have_css('li', text: format_date(proposal_1.end_date))
    expect(page).to have_css('li', text: "R$800,00")

    expect(page).to have_css('h2', text: property_2.title)
    expect(page).to have_css('li', text: property_2.property_location.name)
    expect(page).to have_css('li', text: format_date(proposal_2.start_date))
    expect(page).to have_css('li', text: format_date(proposal_2.end_date))
    expect(page).to have_css('li', text: "R$800,00")

    expect(page).not_to have_css('h2', text: property_3.title)
    expect(page).not_to have_css('li', text: property_3.property_location.name)
    expect(page).not_to have_css('li', text: format_date(proposal_3.end_date))
    expect(page).not_to have_css('li', text: "R$1000,00")
    expect(page).to have_link('Voltar')
  end

  scenario 'and not have any proposal' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minhas propostas'

    expect(page).to have_content('Você ainda não fez nenhuma proposta para locação')
    expect(page).to have_link('Voltar')
  end
end

private

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

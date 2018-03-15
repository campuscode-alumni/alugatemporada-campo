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
    expect(page).to have_content(format_date(proposal.start_date))
    expect(page).to have_content(format_date(proposal.end_date))
    # TO-DO Precisamos corrigir o cálcudo das diárias e padronizar a exibição
    expect(page).to have_content("R$#{proposal.total_amount}")
    expect(page).to have_link('Sair')
    expect(page).to have_link('Voltar')
  end

  scenario 'user can see only your proposal' do
  end

  scenario 'user have not proposal' do
  end
end

private

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

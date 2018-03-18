require 'rails_helper'

feature 'User upload your photo' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on('Meu perfil')
    click_on('Editar perfil')
    attach_file('Minha foto', Rails.root.join('spec','support','user.jpg'))
    click_on('Enviar')

    expect(page).to have_xpath("//img[contains(@src,'user.jpg')]")
    expect(page).to have_css('h1', text: 'Meu perfil')
    expect(page).to have_css('li', text: user.name)
    expect(page).to have_css('li', text: user.email)
    expect(page).to have_css('li', text: user.phone)
    expect(page).to have_content('Minhas propostas')
    expect(page).to have_content('Voltar')
    expect(page).to have_content('Sair')
  end

  scenario 'when missing' do
    user = create(:user)
    login_as(user, scope: :user)

    visit edit_user_path user

    expect(page).to have_xpath("//img[contains(@src,'missing.png')]")
    expect(page).to have_css('h1', text: 'Meu perfil')
    expect(page).to have_css('li', text: user.name)
    expect(page).to have_content('Voltar')
    expect(page).to have_content('Sair')
  end
end

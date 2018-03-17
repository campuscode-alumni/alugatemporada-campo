require 'rails_helper'

feature 'User upload your photo' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on('Meu perfil')
    attach_file('Image', '/path/to/foto-perfil-user.jpg')
    click_on('Upload')

    expect(page).to have_css("img[src*='foto-perfil-user.jpg']")
    expect(page).to have_css('h1', text: user.name)
    expect(page).to have_css('h3', text: user.email)
    expect(page).to have_content('Minhas propostas')
    expect(page).to have_content('Voltar')
    expect(page).to have_content('Sair')
  end
end

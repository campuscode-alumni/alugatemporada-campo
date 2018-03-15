require 'rails_helper'

feature 'Owner login' do
  scenario 'successfuly' do
    owner = create(:property_owner)

    visit root_path

    click_on 'Entrar como proprietário'

    fill_in 'Email', with: owner.email
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(page).to have_link('Minhas propriedades', href: properties_path(owner))
  end

  scenario 'wrong email' do
    visit root_path

    click_on 'Entrar como proprietário'

    fill_in 'Email', with: 'owner@property.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(page).to have_content('Invalid Email or password')
  end
end

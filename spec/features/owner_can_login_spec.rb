require 'rails_helper'

feature 'Owner login' do
  scenario 'successfuly' do
    owner = create(:property_owner)

    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: owner.email
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Minhas propriedades', href: property_owner_properties_path(owner))
  end

  scenario 'wrong email' do
    visit root_path

    click_on 'Entrar'

    fill_in 'Email', with: 'owner@property.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'

    expect(current_path).to eq(new_property_owner_session_path)
    expect(page).to have_content('Invalid Email or password')
  end
end

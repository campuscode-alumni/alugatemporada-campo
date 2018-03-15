require 'rails_helper'

feature 'owner view your own properties' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    property = create(:property, property_owner: owner)

    visit root_path
    click_on 'Entrar como proprietário'
    fill_in 'Email', with: owner.email
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'
    click_on 'Minhas propriedades'

    expect(current_path).to eq properties_path(owner)
    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: property.main_photo)
    expect(page).to have_css('p', text: property.property_location.name)
    expect(page).to have_css('p', text: property.daily_rate)
    expect(page).to have_css('p', text: property.maximum_guests)
    expect(page).to have_link('Ver mais detalhes', href: property_path(property))
  end

  scenario 'owner can see only your own property' do
    owner = create(:property_owner)
    property = create(:property, property_owner: owner)

    another_location = create(:property_location, name: 'quintal da vovo')
    another_owner = create(:property_owner, email: 'email@email.com', password: 87654321)
    another_property = create(:property, property_owner: another_owner, title: 'Casa de boneca',
                              main_photo: 'another photo.jpg', daily_rate: 50, maximum_guests: 2,
                              property_location: another_location)

    visit root_path
    click_on 'Entrar como proprietário'
    fill_in 'Email', with: owner.email
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'
    click_on 'Minhas propriedades'

    expect(current_path).to eq(properties_path(owner))
    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: property.main_photo)
    expect(page).to have_css('p', text: "Localização: #{property.property_location.name}")
    expect(page).to have_css('p', text: "Valor base: #{property.daily_rate}")
    expect(page).to have_css('p', text: "Número máximo de hospedes: #{property.maximum_guests}")
    expect(page).to have_link('Ver mais detalhes', href: property_path(property))
    expect(page).to_not have_css('h1', text: another_property.title)
    expect(page).to_not have_css('h3', text: another_property.main_photo)
    expect(page).to_not have_css('p', text: "Localização: #{another_property.property_location.name}")
    expect(page).to_not have_css('p', text: "Valor base: #{another_property.daily_rate}")
    expect(page).to_not have_css('p', text: "Número máximo de hospedes: #{another_property.maximum_guests}")
    expect(page).to_not have_link('Ver mais detalhes', href: property_path(another_property))
  end

  scenario 'owner have not property' do
    owner = create(:property_owner)

    visit root_path
    click_on 'Entrar como proprietário'
    fill_in 'Email', with: owner.email
    fill_in 'Senha', with: '12345678'
    click_on 'Logar'
    click_on 'Minhas propriedades'

    expect(current_path).to eq(properties_path(owner))
    expect(page).to have_link('Cadastrar nova propriedade', href: new_property_path)
    expect(page).to have_content('Você não possui propriedades cadastrada')
  end
end

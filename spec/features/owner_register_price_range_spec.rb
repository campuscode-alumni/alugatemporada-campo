require "rails_helper"

feature 'Owner register a price range in a property' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    login_as(owner, scope: :property_owner)
    local = PropertyLocation.create(name: 'Campos do Jordão')
    property = Property.create(
                title: 'Casa de Campo',
                description: 'Uma linda casa em Campos de Jordão',
                property_location: local,
                neighborhood: 'Campos',
                rent_purpose: 'Férias',
                main_photo: 'foto.jpg',
                rooms: 5,
                maximum_guests: 15,
                minimum_rent: 3,
                maximum_rent: 15,
                daily_rate: 200.0,
                accessibility: true,
                allow_pets: false,
                allow_smokers: true,
                property_owner: owner
              )

    visit property_path(property)
    click_on 'Cadastrar uma temporada'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Data inicial', with: '01/02/2018'
    fill_in 'Data final', with: '05/02/2018'
    fill_in 'Preço da diária', with: '1000.0'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: 'Preços por temporada')
    expect(page).to have_css('h4', text: 'Carnaval')
    expect(page).to have_css('li', text: 'Data inicial: 01/02/2018')
    expect(page).to have_css('li', text: 'Data final: 05/02/2018')
    expect(page).to have_css('li', text: 'Preço da diária: R$ 1000.0')
    expect(current_path).to eq(property_path(property))
  end

  scenario 'cant be blank' do
    owner = create(:property_owner)
    login_as(owner, scope: :property_owner)
    local = PropertyLocation.create(name: 'Campos do Jordão')
    property = create(:property, property_owner: owner)

    visit property_path property
    click_on 'Cadastrar uma temporada'

    fill_in 'Data inicial', with: '00/00/0000'
    fill_in 'Data final', with: '05/02/2018'
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os dados da temporada')
  end

  scenario 'and end_date must be greater than start_date' do
    owner = create(:property_owner)
    login_as(owner, scope: :property_owner)
    local = PropertyLocation.create(name: 'Campos do Jordão')
    property = create(:property, property_owner: owner)
    start_date = DateTime.now
    end_date = DateTime.now - 10.days

    visit property_path property
    click_on 'Cadastrar uma temporada'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Data inicial', with: format_date(start_date)
    fill_in 'Data final', with: format_date(end_date)
    fill_in 'Preço da diária', with: '1000.0'
    click_on 'Enviar'

    expect(page).to have_content('A data inicial não pode ser maior que a data final')
  end
end

private

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

require ' rails_helper'

feature 'owner add a new photo for a property' do
  scenario 'successfuly' do
    owner = create(:property_owner)
    login_as(owner, scope: :property_owner)
    property = create(:property)

    visit new_property_path(property)
    click_on property_path(property)
    click_on 'Editar Propriedade'

    expect(page).to have_xpath("//img[@src='environ-peeling-kuur.jpg']")

  end
end

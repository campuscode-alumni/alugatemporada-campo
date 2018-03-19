require 'rails_helper'

feature 'owner add a new photo for a property' do
  scenario 'successfuly' do
    property = create(:property)
    owner = property.property_owner

    login_as(owner, scope: :property_owner)

    visit new_property_path(property)
    click_on property_path(property)
    click_on 'Editar Propriedade'
    page.attach_file("property_image", Rails.root + join('spec', 'support', 'casa_no_campo.jpg'))

    expect(page).to have_xpath("//img[@src='casa_no_campo.jpg']")
  end
end

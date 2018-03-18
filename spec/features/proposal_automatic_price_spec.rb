require 'rails_helper'

feature 'owner can see total price of proposal' do
  scenario 'successfuly' do
    property = create(:property, daily_rate: 100)
    proposal = create(:proposal,
                      property: property,
                      start_date: Date.today,
                      end_date: Date.today + 9.days
                     )
    owner = property.property_owner
    login_as(owner, scope: :property_owner)

    visit properties_path(owner)
    click_on 'Visualizar propostas'

    expect(current_path).to eq(property_proposals_path(property))
    expect(page).to have_content('Valor total da proposta: R$1000,00')
  end

	scenario 'Price range' do
		property = create(:property, daily_rate: 100)
		create(:price_range,
					 start_date: Date.today,
					 end_date: Date.today + 9.days,
					 daily_rate: 150,
					 property: property
					)
		create(:proposal,
					 property: property,
					 start_date: Date.today,
					 end_date: Date.today + 9.days
					)
		owner = property.property_owner

		login_as(owner, scope: :property_owner)

		visit properties_path(owner)
		click_on 'Visualizar propostas'

		expect(page).to have_content('Valor total da proposta: R$1500,00')
	end

  scenario 'start before but ends in a price range' do
		property = create(:property, daily_rate: 100)
		create(:price_range,
					 start_date: Date.today,
					 end_date: Date.today + 9.days,
					 daily_rate: 200,
					 property: property
					)
		create(:proposal,
					 property: property,
           start_date: Date.today - 4.days,
					 end_date: Date.today + 5.days
					)
		owner = property.property_owner

		login_as(owner, scope: :property_owner)

		visit properties_path(owner)
		click_on 'Visualizar propostas'

		expect(page).to have_content('Valor total da proposta: R$1600,00')
	end

  scenario 'start within price_range and ends after' do
		property = create(:property, daily_rate: 100)
		create(:price_range,
					 start_date: Date.today,
					 end_date: Date.today + 5.days,
					 daily_rate: 200,
					 property: property
					)
		create(:proposal,
					 property: property,
           start_date: Date.today,
					 end_date: Date.today + 9.days
					)
		owner = property.property_owner

		login_as(owner, scope: :property_owner)

		visit properties_path(owner)
		click_on 'Visualizar propostas'

		expect(page).to have_content('Valor total da proposta: R$1600,00')
  end

  scenario 'with gap between two price ranges' do
		property = create(:property, daily_rate: 100)
		create(:price_range,
					 start_date: Date.today,
					 end_date: Date.today + 2.days,
					 daily_rate: 200,
					 property: property
					)
		create(:price_range,
           start_date: Date.today + 4.days,
					 end_date: Date.today + 6.days,
					 daily_rate: 300,
					 property: property
					)
		create(:proposal,
					 property: property,
           start_date: Date.today,
					 end_date: Date.today + 9.days
					)
		owner = property.property_owner

		login_as(owner, scope: :property_owner)

		visit properties_path(owner)
		click_on 'Visualizar propostas'

		expect(page).to have_content('Valor total da proposta: R$1900,00')
  end
end

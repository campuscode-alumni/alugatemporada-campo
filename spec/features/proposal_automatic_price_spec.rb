require 'rails_helper'

  feature 'owner can see total price of proposal' do
    scenario 'successfuly' do
      property = create(:property, daily_rate: 100)
      proposal = create(:proposal,
                        property: property,
                        start_date: Date.today,
                        end_date: Date.today + 10.days
                      )
      owner = property.property_owner

      login_as(owner, scope: :property_owner)
      visit property_owner_properties_path(owner)
      click_on 'Visualizar propostas'

      expect(current_path).to eq(property_proposals_path(property))
      expect(page).to have_content('Valor total da proposta: R$1000,00')
    end
  end

require 'rails_helper'

feature 'Owner accepted a proposal' do
  scenario 'successfully' do
    proposal = create(:proposal)
    owner = proposal.property.property_owner
    property = proposal.property

    login_as(owner, scope: :property_owner)
    visit root_path
    click_on 'Minhas propriedades'
    click_on property.title

    click_on 'Aceitar'

    proposal.reload
    expect(proposal).to be_accepted
    expect(page).to have_content('Proposta aceita com sucesso!')
    expect(current_path).to eq property_path(property)
  end

  scenario 'and rejected other proposals between same dates' do
    start_date_1 = Time.zone.now + 30.days
    end_date_1 = Time.zone.now + 35.days
    start_date_2 = Time.zone.now + 28.days
    end_date_2 = Time.zone.now + 32.days
    owner = create(:property_owner)
    property = create(:property, property_owner: owner)
    user = create(:user)
    proposal_1 = create(:proposal, user: user, property: property, start_date: start_date_1, end_date: end_date_1)
    proposal_2 = create(:proposal, user: user, property: property, start_date: start_date_2, end_date: end_date_2)

    login_as(owner, scope: :property_owner)
    visit root_path
    click_on 'Minhas propriedades'
    click_on property.title
    click_on 'Aceitar' # proposal 1

    property.proposals.reload
    expect(proposal_1).to be_accepted
    expect(proposal_2).to be_rejected
  end
end

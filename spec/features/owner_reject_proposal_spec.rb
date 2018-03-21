require 'rails_helper'

feature 'owner reject a proposal' do
  scenario 'successfuly' do
    proposal = create(:proposal)
    owner = proposal.property.property_owner

    login_as(owner, scope: :property_owner)

    visit property_path(proposal.property)
    click_on 'Rejeitar proposta'

    prop = Proposal.last

    expect(prop).to be_rejected
  end

  scenario 'do not show rejected proposals' do
    proposal = create(:proposal)
    owner = proposal.property.property_owner

    login_as(owner, scope: :property_owner)

    visit property_path(proposal.property)
    click_on 'Rejeitar proposta'

    prop = Proposal.last

    expect(current_path).to eq(property_path(proposal.property))
    expect(page).to_not have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to_not have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to_not have_css('li', text: 'Vou levar meu pet')
    expect(page).to_not have_css('li', text: 'Sou fumante')
    expect(page).to_not have_css('li', text: 'Maiores detalhes: N/A')
  end

  scenario 'reject only one proposal' do
    proposal = create(:proposal)
    user = proposal.user
    property = proposal.property
    proposal1 = create(:proposal, property: property, user: user,
      rent_purpose: 'Festa de arromba',
      total_guest: 100,
      details: 'Festa para os jogadores convocados para a NHL',
      pet: false,
      smoker: false,
    )
    owner = proposal.property.property_owner

    login_as(owner, scope: :property_owner)

    visit property_path(proposal.property)
    within("div#proposal_#{proposal.id}") do
      click_on 'Rejeitar proposta'
    end

    prop = Proposal.last

    expect(current_path).to eq(property_path(proposal.property))
    expect(page).to_not have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to_not have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to_not have_css('li', text: 'Vou levar meu pet')
    expect(page).to_not have_css('li', text: 'Sou fumante')
    expect(page).to_not have_css('li', text: 'Maiores detalhes: N/A')

    expect(page).to have_css('li', text: "Finalidade da proposta: #{prop.rent_purpose}")
    expect(page).to have_css('li', text: "Quantidade de hospedes: #{prop.total_guest}")
    expect(page).to have_css('li', text: "Maiores detalhes: #{prop.details}")
  end
end

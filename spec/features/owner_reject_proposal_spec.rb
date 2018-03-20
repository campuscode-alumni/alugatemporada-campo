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
    expect(current_path).to eq(property_path(proposal.property))
    expect(page).to_not have_content('Sua proposta foi enviada com sucesso!')
    expect(page).to_not have_css('li', text: 'Finalidade da proposta: Despedida de solteiro')
    expect(page).to_not have_css('li', text: 'Quantidade de hospedes: 12')
    expect(page).to_not have_css('li', text: "Valor total da proposta: R$2200,00")
    expect(page).to_not have_css('li', text: 'Vou levar meu pet')
    expect(page).to_not have_css('li', text: 'Sou fumante')
    expect(page).to_not have_css('li', text: 'Maiores detalhes: N/A')
  end
end

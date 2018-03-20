class ProposalsController < ApplicationController
  def create
    proposal_params = params.require(:proposal).permit(
                        :rent_purpose, :total_guest,:start_date, :end_date,
                        :pet, :smoker, :total_amount, :details, :property_id,
                        :user_id
                      )

    @property = Property.find(params[:property_id])
    @proposal = Proposal.new(proposal_params)
    @proposal.property = @property
    @proposal.user = current_user

    if @proposal.save
      flash[:notice] = 'Sua proposta foi enviada com sucesso!'
      redirect_to user_proposals_path(current_user)
    else
      flash[:errors] = 'Não foi possível envia sua proposta!'
      render :new
    end
  end

  def index
    if property_owner_signed_in?
      @proposals = Proposal.where(property_id: params[:property_id])

      if @proposals.empty?
        flash[:alert] = 'Seu imóvel ainda não recebeu nenhuma proposta'
      end
    end

    if user_signed_in?
      @proposals = current_user.proposals

      if @proposals.empty?
        flash[:alert] = 'Você ainda não fez nenhuma proposta para locação'
      end
    end
  end

  def new
    @property = Property.find(params[:property_id])
    @proposal = Proposal.new
  end

  def reject
    Proposal.find(params[:proposal_id]).rejected!
    redirect_to property_path(params[:property_id])
  end
end

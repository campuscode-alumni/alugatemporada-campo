class PropertiesController < ApplicationController
  def show
    @property = Property.find_by(id: params[:id])
    if @property.nil?
      flash[:alert] = 'Imóvel não encontrado'
      redirect_to root_path
    end
  end
end

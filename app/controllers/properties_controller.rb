class PropertiesController < ApplicationController
  def search
    @properties = Property.where(property_location_id: params[:q])

    if @properties.empty?
      flash[:alert] = 'Nenhum resultado encontrado'
    end
  end

  def show
    @property = Property.find_by(id: params[:id])
    if @property.nil?
      redirect_to root_path
    end
  end

  def new
    @property = Property.new
  end

  def create
    property_params = params.require(:property).permit(:title,:maximum_guests, :maximum_rent,
                      :minimum_rent, :maximum_rent, :daily_rate, :rent_purpose,
                      :property_location, :description, :neighborhood, :accessibility,
                      :allow_pets, :allow_smokers, :rooms, :main_photo)
    @property = Property.new(property_params)
    @property.save
    redirect_to @property
  end

end

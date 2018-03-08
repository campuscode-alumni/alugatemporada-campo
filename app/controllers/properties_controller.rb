class PropertiesController < ApplicationController
  def search
    @properties = Property.where(property_location_id: params[:q])
  end
end

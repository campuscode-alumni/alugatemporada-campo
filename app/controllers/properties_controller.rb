class PropertiesController < ApplicationController
  def search
    @properties = Property.where("property_location LIKE ?", params[:q])
  end
end

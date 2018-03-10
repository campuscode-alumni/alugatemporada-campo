class PriceRangesController < ApplicationController
  def new
    @property = Property.find_by(id: params[:property_id])
    @price_range = PriceRange.new
  end

  def create
    create_params = params.require(:price_range).permit(:description,
                      :start_date, :end_date, :daily_rate, :property_id
                    )

    @property = Property.find(params[:property_id])
    @price_range = PriceRange.new(create_params)

    @price_range.property = @property
    @price_range.save

    redirect_to property_path @property
  end
end

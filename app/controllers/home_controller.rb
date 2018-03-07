class HomeController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc).last(10)
  end
end

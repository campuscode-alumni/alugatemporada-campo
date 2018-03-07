class HomeController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc).last(10)

    if @properties.empty?
      @message = "Não existe nenhum imóvel cadastrado no momento"
    end
  end
end

class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

end

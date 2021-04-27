class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def show
    @pet = Plot.find(params[:id])
  end

  def destroy
    plot = Plot.find(params[:id])
    plant = Plant.find(params[:plant])
    plot.plants.delete(plant)
    redirect_to '/plots'
  end
end

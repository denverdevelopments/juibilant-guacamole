class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.plants
    # @sorted_plants = @garden.unique_harvested
  end
end

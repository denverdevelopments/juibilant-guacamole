class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.unique_harvestable
  end
end

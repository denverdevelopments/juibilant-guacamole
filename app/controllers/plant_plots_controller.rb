class PlantPlotsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.find_by(plant_id: params[:format], plot_id: params[:plot_id])
    plant_plot.destroy
    redirect_to '/plots'
   end
end

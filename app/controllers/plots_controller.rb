class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def show
    @pet = Plot.find(params[:id])
  end

end

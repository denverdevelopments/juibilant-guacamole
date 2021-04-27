require 'rails_helper'

RSpec.describe 'garden show page' do
  before(:each) do
    @garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)

    @plot_1 = @garden_1.plots.create!(number: 1, size: 'Small', direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 22, size: 'Large', direction: "West")

    @plant_1 = Plant.create!(name: 'Lily', description: "White flower", days_to_harvest: 21)
    @plant_2 = Plant.create!(name: 'Daisy', description: "Small red petals", days_to_harvest: 13)
    @plant_3 = Plant.create!(name: 'Rose', description: "Many thorny stems", days_to_harvest: 110)
    @plant_4 = Plant.create!(name: 'Cactus', description: "Prickly, not much water", days_to_harvest: 45)
    @plant_5 = Plant.create!(name: 'Lemon Tree', description: "Small tree, will bear fruit", days_to_harvest: 212)

    PlantPlot.create!(plant: @plant_1, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_1)
    PlantPlot.create!(plant: @plant_3, plot: @plot_1)
    PlantPlot.create!(plant: @plant_4, plot: @plot_2)
    PlantPlot.create!(plant: @plant_1, plot: @plot_2)
  end

  it 'has the name of the garden' do
      visit "/gardens/#{@garden_1.id}"
    expect(page).to have_content("#{@garden_1.name}")
  end

  it 'has names of plants taking less than 100 days to harvest, no duplicates' do
      visit "/gardens/#{@garden_1.id}"
    expect(page).to have_content("#{@plant_1.name}")
    expect(page).to have_content("#{@plant_2.name}")
    expect(page).to have_content("#{@plant_4.name}")
    expect(page).to_not have_content("#{@plant_3.name}")
  end

end

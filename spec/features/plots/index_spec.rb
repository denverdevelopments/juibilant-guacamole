require 'rails_helper'

RSpec.describe 'the plots index page' do
  before(:each) do
    @garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
    @garden_2 = Garden.create!(name: 'My Backyard', organic: false)

    @plot_1 = @garden_1.plots.create!(number: 1, size: 'Small', direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 22, size: 'Large', direction: "West")
    @plot_3 = @garden_2.plots.create!(number: 4, size: 'Medium', direction: "Southwest")
    @plot_4 = @garden_2.plots.create!(number: 333, size: 'Small', direction: "South")

    @plant_1 = Plant.create!(name: 'Lily', description: "White flower", days_to_harvest: 21)
    @plant_2 = Plant.create!(name: 'Daisy', description: "Small red petals", days_to_harvest: 13)
    @plant_3 = Plant.create!(name: 'Rose', description: "Many thorny stems", days_to_harvest: 110)
    @plant_4 = Plant.create!(name: 'Cactus', description: "Prickly, not much water", days_to_harvest: 45)
    @plant_5 = Plant.create!(name: 'Lemon Tree', description: "Small tree, will bear fruit", days_to_harvest: 212)
    @plant_6 = Plant.create!(name: 'Fern', description: "Ground cover", days_to_harvest: 8)

    PlantPlot.create!(plant: @plant_1, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_1)
    PlantPlot.create!(plant: @plant_3, plot: @plot_1)
    PlantPlot.create!(plant: @plant_4, plot: @plot_2)
    PlantPlot.create!(plant: @plant_5, plot: @plot_3)
    PlantPlot.create!(plant: @plant_6, plot: @plot_3)
  end

  it 'shows all the plot numbers with plot plants, and remove plant links' do
      visit "/plots"
      expect(page).to have_content("Plots Index")

    within("#plots_list") do
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content("#{@plot_1.number}")
        expect(page).to have_content("#{@plant_1.name}")
        expect(page).to have_link("Remove #{@plant_1.name}")
        expect(page).to have_content("#{@plant_2.name}")
        expect(page).to have_link("Remove #{@plant_2.name}")
        expect(page).to have_content("#{@plant_3.name}")
        expect(page).to have_link("Remove #{@plant_3.name}")
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content("#{@plot_2.number}")
        expect(page).to have_content("#{@plant_4.name}")
        expect(page).to have_link("Remove #{@plant_4.name}")
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content("#{@plot_3.number}")
        expect(page).to have_content("#{@plant_5.name}")
        expect(page).to have_link("Remove #{@plant_5.name}")
        expect(page).to have_content("#{@plant_6.name}")
        expect(page).to have_link("Remove #{@plant_6.name}")
      end

      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content("#{@plot_4.number}")
        expect(page).to_not have_content("#{@plant_6.name}")
      end
    end
  end

  it 'has a link to remove a plant from a plot' do
        visit "/plots"
      expect(page).to have_content("#{@plot_1.number}")
      expect(page).to have_content("#{@plant_1.name}")
      expect(page).to have_link("Remove #{@plant_1.name}")
      expect(page).to have_content("#{@plant_2.name}")
      expect(page).to have_link("Remove #{@plant_2.name}")
      expect(page).to have_content("#{@plant_3.name}")
      expect(page).to have_link("Remove #{@plant_3.name}")

        click_link("Remove #{@plant_1.name}")
      expect(page).to have_current_path("/plots")
      expect(page).to_not have_content("#{@plant_1.name}")
      expect(page).to have_content("#{@plant_2.name}")
      expect(page).to have_content("#{@plant_3.name}")
  end
end

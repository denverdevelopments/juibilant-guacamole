# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Garden.destroy_all
Plot.destroy_all
Plant.destroy_all
PlantPlot.destroy_all

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

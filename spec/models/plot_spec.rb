require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plant_plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  before(:each) do
    @garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
    @garden_2 = Garden.create!(name: 'My Backyard', organic: false)

    @plot_1 = @garden_1.plots.create!(number: 1, size: 'Small', direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 22, size: 'Large', direction: "West")
    @plot_3 = @garden_2.plots.create!(number: 4, size: 'Medium', direction: "Southwest")
    # @plot_4 = @garden_2.plots.create!(number: 333, size: 'Small', direction: "South")

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

  # describe 'class methods' do
  #   describe '#search' do
  #     it 'returns partial matches' do
  #       expect(Pet.search("Claw")).to eq([@pet_2])
  #     end
  #   end
  #
  #   describe '#adoptable' do
  #     it 'returns adoptable pets' do
  #       expect(Pet.adoptable).to eq([@pet_1, @pet_2])
  #     end
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '.shelter_name' do
  #     it 'returns the shelter name for the given pet' do
  #       expect(@pet_3.shelter_name).to eq(@shelter_1.name)
  #     end
  #   end
  #
  #   describe '.count_pending_applications' do
  #     it "returns count of pending applications" do
  #       expect(@pet_1.count_pending_applications).to eq(1)
  #     end
  #   end
  #
  #   describe '.application_status' do
  #     it "returns the status of application for given applicant" do
  #       expect(@pet_1.application_status(@kon)).to eq("Pending")
  #     end
  #   end
  #
  # end
end

require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many(:plant_plots) }
    it { should have_many(:plots).through(:plant_plots) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:days_to_harvest) }
    it { should validate_numericality_of(:days_to_harvest) }
  end

  # before(:each) do
  #   @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
  #   @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
  #   @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  #   @kon = @pet_1.applications.create!(name: "Kon", street: "123 nowhere", city: "sleepy", state: "TN", zip_code: 32322, justification: "I hate turtles", status: "Pending")
  # end
  #
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

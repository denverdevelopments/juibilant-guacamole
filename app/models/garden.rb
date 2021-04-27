class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_harvestable
    self.plants.distinct.where("plants.days_to_harvest < ?", 100)
  end

end

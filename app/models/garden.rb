class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_harvestable
    self.plants.distinct.where("plants.days_to_harvest < ?", 100)
  end

  def most_to_least   #Extension attempt, need to fix count
    self.plants.select("plants.*, count(plot.plants) as most_used").order(most_used: :desc)
  end

end

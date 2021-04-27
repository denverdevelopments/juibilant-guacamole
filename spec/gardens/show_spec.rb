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

    PlantPlot.create!(plant: @plant_1, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_1)
    PlantPlot.create!(plant: @plant_3, plot: @plot_1)
    PlantPlot.create!(plant: @plant_4, plot: @plot_2)
  end

  it 'has the name of the garden' do
    garden = Garden.create!(name: "Anthony")
    visit "/gardens/#{garden.id}"
    expect(page).to have_content("#{garden.name}")
  end
  it 'has the names and descriptions of all the gardens dishes' do
    chef = Chef.create!(name: "Anthony")
    dish1 = chef.dishes.create!(name: "Yum", description: "Very yum")
    dish2 = chef.dishes.create!(name: "Tasty", description: "Very tasty")

    visit "/chefs/#{chef.id}"

    within("#chef_dishes") do
      within("#dish-#{dish1.id}") do
        expect(page).to have_content("#{dish1.name}")
        expect(page).to have_content("#{dish1.description}")
      end

      within("#dish-#{dish2.id}") do
        expect(page).to have_content("#{dish2.name}")
        expect(page).to have_content("#{dish2.description}")
      end
    end
  end

  it 'has a list of all ingredients with calories, no duplicates' do
    chef = Chef.create!(name: "Anthony")
    dish1 = chef.dishes.create!(name: "Yum", description: "Very yum")
    dish2 = chef.dishes.create!(name: "Tasty", description: "Very tasty")
    ingredient2 = dish1.ingredients.create!(name: "carrot", calories: 20)
    ingredient6 = dish2.ingredients.create!(name: "onion", calories: 10)
    ingredient1 = dish1.ingredients.create!(name: "onion", calories: 10)
    ingredient5 = dish2.ingredients.create!(name: "butter", calories: 50)
    ingredient4 = dish2.ingredients.create!(name: "garlic", calories: 40)
    ingredient3 = dish1.ingredients.create!(name: "potato", calories: 30)

    visit "/chefs/#{chef.id}"

    within("#chef_ingredients") do
        expect(page).to have_content(ingredient1.name.capitalize)
        expect(page).to have_content(ingredient1.calories)

        expect(page).to have_content(ingredient2.name.capitalize)
        expect(page).to have_content(ingredient2.calories)

        expect(page).to have_content(ingredient3.name.capitalize)
        expect(page).to have_content(ingredient3.calories)

        expect(page).to have_content(ingredient4.name.capitalize)
        expect(page).to have_content(ingredient4.calories)

        expect(page).to have_content(ingredient5.name.capitalize)
        expect(page).to have_content(ingredient5.calories)

        expect(page).to have_content(ingredient6.name.capitalize)
        expect(page).to have_content(ingredient6.calories)
    end
  end

  it 'has ordered the list of ingredients from most calories to least' do
    chef = Chef.create!(name: "Anthony")
    dish1 = chef.dishes.create!(name: "Yum", description: "Very yum")
    dish2 = chef.dishes.create!(name: "Tasty", description: "Very tasty")
    ingredient2 = dish1.ingredients.create!(name: "carrot", calories: 20)
    ingredient1 = dish1.ingredients.create!(name: "onion", calories: 10)
    ingredient5 = dish2.ingredients.create!(name: "butter", calories: 50)
    ingredient4 = dish2.ingredients.create!(name: "garlic", calories: 40)
    ingredient3 = dish1.ingredients.create!(name: "potato", calories: 30)

    visit "/chefs/#{chef.id}"

    expect(ingredient5.name.capitalize).to appear_before(ingredient4.name.capitalize)
    expect(ingredient4.name.capitalize).to appear_before(ingredient3.name.capitalize)
    expect(ingredient3.name.capitalize).to appear_before(ingredient2.name.capitalize)
    expect(ingredient2.name.capitalize).to appear_before(ingredient1.name.capitalize)
  end
  describe 'each dish has a button to delete the dish' do
    it 'has a button next to each dish to delete the dish' do
      chef = Chef.create!(name: "Anthony")
      dish1 = chef.dishes.create!(name: "Yum", description: "Very yum")
      dish2 = chef.dishes.create!(name: "Tasty", description: "Very tasty")

      visit "/chefs/#{chef.id}"

      within("#chef_dishes") do
        within("#dish-#{dish1.id}") do
          expect(page).to have_button("Delete Dish")
          click_button("Delete Dish")
          expect(current_path).to eq("/chefs/#{chef.id}")
        end
        expect(page).to_not have_content("#{dish1.name}")
        expect(page).to_not have_content("#{dish1.description}")

        within("#dish-#{dish2.id}") do
          expect(page).to have_button("Delete Dish")
          click_button("Delete Dish")
          expect(current_path).to eq("/chefs/#{chef.id}")
        end
        expect(page).to_not have_content("#{dish2.name}")
        expect(page).to_not have_content("#{dish2.description}")
      end
    end
  end
end

#RYAN
RSpec.describe "Chef Show Page" do
  describe "As a visitor" do
    context "When I visit a chefs show page" do
      before :each do
        @chef = Chef.create!(name: "Mario")
        @dish_1 = Dish.create!(name: 'lasagna', description: 'vegan with red sauce', chef_id: @chef.id)
        @dish_2 = Dish.create!(name: 'pizza', description: 'cheese and pepperoni', chef_id: @chef.id)
        @dish_3 = Dish.create!(name: 'steak', description: 'filet with pepper sauce', chef_id: @chef.id)
        @dish_4 = Dish.create!(name: 'shrimp', description: 'boiled and seasoned')
        @ingredient_1 = Ingredient.create!(name: 'tomato', calories: 45)
        @ingredient_2 = Ingredient.create!(name: 'flour', calories: 95)
        @ingredient_3 = Ingredient.create!(name: 'pepperoni', calories: 60)
        @ingredient_4 = Ingredient.create!(name: 'sausage', calories: 80)
        @ingredient_5 = Ingredient.create!(name: 'carrot', calories: 30)
        @ingredient_6 = Ingredient.create!(name: 'chili', calories: 25)
        @dish_1.ingredients << [@ingredient_1, @ingredient_2, @ingredient_3]
        @dish_2.ingredients << [@ingredient_2, @ingredient_3, @ingredient_4, @ingredient_5]
        @dish_3.ingredients << [@ingredient_5, @ingredient_6]
        visit chef_path(@chef)
      end

      it "Then I see the name of the chef" do
        expect(page).to have_content(@chef.name)
      end

      it "And I see the names and descriptions of all the chefs dishes" do
        within ".dish-describe" do
          expect(page).to have_content(@dish_1.name)
          expect(page).to have_content(@dish_2.name)
          expect(page).to have_content(@dish_3.name)
          expect(page).to have_content(@dish_1.description)
          expect(page).to have_content(@dish_2.description)
          expect(page).to have_content(@dish_3.description)
        end
      end

      it "Then I see the name and calories of all ingredients used in dishes" do
        within ".ingredients-describe" do
          expect(page).to have_content(@ingredient_1.name)
          expect(page).to have_content(@ingredient_1.calories)
          expect(page).to have_content(@ingredient_2.name)
          expect(page).to have_content(@ingredient_2.calories)
          expect(page).to have_content(@ingredient_3.name)
          expect(page).to have_content(@ingredient_3.calories)
          expect(@ingredient_2.name).to appear_before(@ingredient_3.name)
          expect(@ingredient_3.name).to appear_before(@ingredient_1.name)
        end
      end

      context "I see a button next to each dish to remove it from this chef" do
        it "When I click this button I am returned to the chefs show page" do
          expect(page).to have_button('Remove')
          click_on "Remove #{@dish_1.id}"
          expect(current_path).to eq(chef_path(@chef))
          expect(page).to_not have_content("Remove #{@dish_1.id}")
        end
      end

      # describe "I see a section for most popular ingredients" do
        # it "I see the three most popular ingredients that the chef uses" do
        #   within ".popular-ingredients" do
        #     expect(page).to have_content(@ingredient_2)
        #     expect(page).to have_content(@ingredient_3)
        #     expect(page).to have_content(@ingredient_5)
        #     expect(page).to_not have_content(@ingredient_6)
        #   end
        # end
      # end
    end
  end
end

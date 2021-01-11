require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/item'
require './lib/event'
require './lib/food_truck'

RSpec.configure do |config|
  config.default_formatter = 'doc'
  config.mock_with :mocha
end

RSpec.describe 'Event Spec Harness' do
  before :each do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1 = FoodTruck.new("Rocky Mountain Fresh")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
  end

  describe 'Iteration 1' do
    it '1. Item Creation' do
      expect(Item).to respond_to(:new).with(1).argument
      expect(@item1).to be_an_instance_of(Item)
      expect(@item1).to respond_to(:name).with(0).argument
      expect(@item1.name).to eq('Peach Pie (Slice)')
      expect(@item1).to respond_to(:price).with(0).argument
      expect(@item1.price).to eq(3.75)
    end

    it '2. FoodTruck Creation' do
      expect(FoodTruck).to respond_to(:new).with(1).argument
      expect(@food_truck1).to be_an_instance_of(FoodTruck)
      expect(@food_truck1).to respond_to(:name).with(0).argument
      expect(@food_truck1.name).to eq('Rocky Mountain Fresh')
      expect(@food_truck1).to respond_to(:inventory).with(0).argument
      expect(@food_truck1.inventory).to eq({})
    end

    it '3. FoodTruck #check_stock' do
      expect(@food_truck1).to respond_to(:check_stock).with(1).argument
      expect(@food_truck1.check_stock(@item1)).to eq(0)
    end

    it '4. FoodTruck #stock' do
      expect(@food_truck1).to respond_to(:stock).with(2).argument
      @food_truck1.stock(@item1, 30)
      @food_truck1.stock(@item1, 25)
      @food_truck1.stock(@item2, 12)

      expect(@food_truck1.check_stock(@item1)).to eq(55)
      expect(@food_truck1.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end

  describe 'Iteration 2' do
    before :each do
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3.stock(@item1, 65)
      @event = Event.new("South Pearl Street Farmers Market")
    end

    it '5. Event Creation' do
      expect(Event).to respond_to(:new).with(1).argument
      expect(@event).to be_an_instance_of(Event)
      expect(@event).to respond_to(:name).with(0).argument
      expect(@event.name).to eq("South Pearl Street Farmers Market")
      expect(@event).to respond_to(:food_trucks).with(0).argument
      expect(@event.food_trucks).to eq([])
    end

    it '6. Event #add_food_truck' do
      expect(@event).to respond_to(:add_food_truck).with(1).argument
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end

    it '7. Event #food_truck_names' do
      expect(@event).to respond_to(:food_truck_names).with(0).argument
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_truck_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '8. Event #food_trucks_that_sell' do
      expect(@event).to respond_to(:food_trucks_that_sell).with(1).argument
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
      expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
    end

    it '9. FoodTruck #potential_revenue' do
      expect(@food_truck1).to respond_to(:potential_revenue).with(0).argument
      expect(@food_truck1.potential_revenue).to eq(148.75)
      expect(@food_truck2.potential_revenue).to eq(345.0)
      expect(@food_truck3.potential_revenue).to eq(243.75)
    end
  end

  describe 'Iteration 3' do
    before :each do
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event = Event.new("South Pearl Street Farmers Market")
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it '10. Event #total_inventory' do
      expect(@event).to respond_to(:total_inventory).with(0).argument
      expected = {
        @item1 => {
          quantity: 100,
          food_trucks: [@food_truck1, @food_truck3]
        },
        @item2 => {
          quantity: 7,
          food_trucks: [@food_truck1]
        },
        @item4 => {
          quantity: 50,
          food_trucks: [@food_truck2]
        },
        @item3 => {
          quantity: 35,
          food_trucks: [@food_truck2, @food_truck3]
        },
      }

      expect(@event.total_inventory).to eq(expected)
    end

    it '11. Event #overstocked_items' do
      expect(@event).to respond_to(:overstocked_items).with(0).argument
      expect(@event.overstocked_items).to eq([@item1])
    end

    it '12. Event #sorted_item_list' do
      expect(@event).to respond_to(:sorted_item_list).with(0).argument
      expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
    end
  end

  describe 'Iteration 4' do
    it '13. Event #date' do
      Date.expects(:today).returns(Date.new(2020, 02, 12))
      event = Event.new("South Pearl Street Farmers Market")

      expect(event).to respond_to(:date).with(0).argument
      expect(event.date).to eq('12/02/2020')
    end

    it '14 Event #sell' do
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: '$0.50'})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      item5 = Item.new({name: 'Onion', price: '$0.25'})
      event = Event.new("South Pearl Street Farmers Market")
      food_truck1 = FoodTruck.new("Rocky Mountain Fresh")
      food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      food_truck3 = FoodTruck.new("Palisade Peach Shack")
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock("Peach-Raspberry Nice Cream", 25)
      food_truck3.stock(item1, 65)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event).to respond_to(:sell).with(2).argument

      expect(event.sell(item1, 200)).to eq(false)
      expect(event.sell(item5, 1)).to eq(false)
      expect(event.sell(item4, 5)).to eq(true)
      expect(food_truck2.check_stock(item4)).to eq(45)
      expect(event.sell(item1, 40)).to eq(true)
      expect(food_truck1.check_stock(item1)).to eq(0)
      expect(food_truck3.check_stock(item1)).to eq(60)
    end
  end
end

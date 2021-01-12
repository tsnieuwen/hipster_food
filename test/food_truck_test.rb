require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'

class FoodTruckTest < Minitest::Test

  def test_it_exists
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    assert_instance_of FoodTruck, food_truck
  end

  def test_it_has_readable_attributes
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    expected = {}
    assert_equal 'Rocky Mountain Pies', food_truck.name
    assert_equal expected, food_truck.inventory
  end

  def test_check_stock
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    assert_equal 0, food_truck.check_stock(item1)
  end

  def test_stock
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck.stock(item1, 30)
    expected_inventory = {item1 => 30}
    assert_equal expected_inventory, food_truck.inventory
    assert_equal 30, food_truck.check_stock(item1)
    food_truck.stock(item1, 25)
    assert_equal 55, food_truck.check_stock(item1)
    food_truck.stock(item2, 12)
    expected_inventory = {item1 => 55, item2 => 12}
    assert_equal expected_inventory, food_truck.inventory
  end

  def test_potential_revenue
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    food_truck3.stock(item1, 65)
    assert_equal 148.75, food_truck1.potential_revenue
    assert_equal 345.00, food_truck2.potential_revenue
    assert_equal 243.75, food_truck3.potential_revenue
  end

end

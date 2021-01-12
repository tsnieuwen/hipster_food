class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.keys.include?(item)
    end
  end

  def available_items
    @food_trucks.map do |food_truck|
      food_truck.inventory.keys
    end.flatten.uniq
  end

  def total_quantity_of_item(item)
    total_item = 0
    @food_trucks.each do |truck|
      if truck.inventory.keys.include?(item)
        total_item += truck.inventory[item]
      end
    end
    total_item
  end

  def item_info(item)
    info = Hash.new
    info[:quantity] = total_quantity_of_item(item)
    info[:food_trucks] = food_trucks_that_sell(item)
    info
  end

  def total_inventory
    total_inventory = Hash.new
    available_items.each do |item|
      total_inventory[item] = item_info(item)
    end
    total_inventory
  end

  def overstocked_items
    overstocked_items = []
    available_items.each do |item|
      if (total_inventory[item][:food_trucks].count > 1)
        overstocked_items << item
      end
    end
  end
# (total_inventory[item][:food_trucks].count > 1)


end

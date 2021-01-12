class FoodTruck
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory[item] == nil
      0
    else
      @inventory[item]
    end
  end

  def stock(item, quantity)
    if @inventory[item] == nil
      @inventory[item] = quantity
    else
      @inventory[item] = @inventory[item] + quantity
    end
  end

  def potential_revenue
    potential_revenue = 0
    @inventory.each do |item, quantity|
      potential_revenue += item.price * quantity
    end
    potential_revenue
  end

end

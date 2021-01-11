# Event


## Instructions

* Fork this Repository
* Clone your forked repo to your computer.
* Complete the activity below.
* Push your solution to your forked repo
* Submit a pull request from your repository to this repository
  * Put your name in your PR!

## Iteration 1 - Items & FoodTrucks

The Event will need to keep track of its FoodTrucks and their Items. Each FoodTruck will be able to report its total inventory, stock items, and return the quantity of items. Any item not in stock should return `0` by default.

Use TDD to create a `FoodTruck` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item2.name
#=> "Apple Pie (Slice)"

pry(main)> item2.price
#=> 2.50

pry(main)> food_truck = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007f85683152f0...>

pry(main)> food_truck.name
#=> "Rocky Mountain Pies"

pry(main)> food_truck.inventory
#=> {}

pry(main)> food_truck.check_stock(item1)
#=> 0

pry(main)> food_truck.stock(item1, 30)

pry(main)> food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 30}

pry(main)> food_truck.check_stock(item1)
#=> 30

pry(main)> food_truck.stock(item1, 25)

pry(main)> food_truck.check_stock(item1)
#=> 55

pry(main)> food_truck.stock(item2, 12)

pry(main)> food_truck.inventory
#=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
```

## Iteration 2 - Event and FoodTrucks

A FoodTruck will be able to calculate their `potential_revenue` - the sum of all their items' price * quantity.

A Event is responsible for keeping track of FoodTrucks. It should have a method called `food_truck_names` that returns an array of all the FoodTruck's names.

Additionally, the Event should have a method called `food_trucks_that_sell` that takes an argument of an item represented as a String. It will return a list of FoodTrucks that have that item in stock.

Use TDD to create a `Event` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> event = Event.new("South Pearl Street Farmers Market")
#=> #<Event:0x00007fe134933e20...>

pry(main)> event.name
#=> "South Pearl Street Farmers Market"

pry(main)> event.food_trucks
#=> []

pry(main)> food_truck1 = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007fe1348a1160...>

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#=> #<Item:0x007f9c562a5f18...>

pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
#=> #<Item:0x007f9c56343038...>

pry(main)> food_truck1.stock(item1, 35)

pry(main)> food_truck1.stock(item2, 7)

pry(main)> food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
#=> #<FoodTruck:0x00007fe1349bed40...>

pry(main)> food_truck2.stock(item4, 50)

pry(main)> food_truck2.stock(item3, 25)

pry(main)> food_truck3 = FoodTruck.new("Palisade Peach Shack")
#=> #<FoodTruck:0x00007fe134910650...>

pry(main)> food_truck3.stock(item1, 65)

pry(main)> event.add_food_truck(food_truck1)

pry(main)> event.add_food_truck(food_truck2)

pry(main)> event.add_food_truck(food_truck3)

pry(main)> event.food_trucks
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe1349bed40...>, #<FoodTruck:0x00007fe134910650...>]

pry(main)> event.food_truck_names
#=> ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

pry(main)> event.food_trucks_that_sell(item1)
#=> [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe134910650...>]

pry(main)> event.food_trucks_that_sell(item4)
#=> [#<FoodTruck:0x00007fe1349bed40...>]

pry(main)> food_truck1.potential_revenue
#=> 148.75

pry(main)> food_truck2.potential_revenue
#=> 345.00

pry(main)> food_truck3.potential_revenue
#=> 243.75
```

## Iteration 3 - Items sold at the Event

Add a method to your `Event` class called `sorted_item_list` that returns a list of names of all items the FoodTrucks have in stock, sorted alphabetically. This list should not include any duplicate items.

Additionally, your `Event` class should have a method called `total_inventory` that reports the quantities of all items sold at the event. Specifically, it should return a hash with items as keys and hash as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and food_trucks pointing to an array of the food trucks that sell that item.

You `Event` will also be able to identify `overstocked_items`.  An item is overstocked if it is sold by more than 1 food truck AND the total quantity is greater than 50.

Use TDD to update your `Event` class so that it responds to the following interaction pattern:

```ruby
pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> event = Event.new("South Pearl Street Farmers Market")
#=> #<Event:0x00007fe134933e20...>

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#=> #<Item:0x007f9c562a5f18...>

pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
#=> #<Item:0x007f9c56343038...>

pry(main)> food_truck1 = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007fe1348a1160...>

pry(main)> food_truck1.stock(item1, 35)

pry(main)> food_truck1.stock(item2, 7)

pry(main)> food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
#=> #<FoodTruck:0x00007fe1349bed40...>

pry(main)> food_truck2.stock(item4, 50)

pry(main)> food_truck2.stock(item3, 25)

pry(main)> food_truck3 = FoodTruck.new("Palisade Peach Shack")
#=> #<FoodTruck:0x00007fe134910650...>

pry(main)> food_truck3.stock(item1, 65)

pry(main)> food_truck3.stock(item3, 10)

pry(main)> event.add_food_truck(food_truck1)

pry(main)> event.add_food_truck(food_truck2)

pry(main)> event.add_food_truck(food_truck3)

pry(main)> event.total_inventory
#=> {
  #   #<Item:0x007f9c56740d48...> => {
  #     quantity: 100,
  #     food_trucks: [#<FoodTruck:0x00007fe1348a1160...>, #<FoodTruck:0x00007fe134910650...>]
  #   },
  #   #<Item:0x007f9c565c0ce8...> => {
  #     quantity: 7,
  #     food_trucks: [#<FoodTruck:0x00007fe1348a1160...>]
  #   },
  #   #<Item:0x007f9c56343038...> => {
  #     quantity: 50,
  #     food_trucks: [#<FoodTruck:0x00007fe1349bed40...>]
  #   },
  #   #<Item:0x007f9c562a5f18...> => {
  #     quantity: 35,
  #     food_trucks: [#<FoodTruck:0x00007fe1349bed40...>, #<FoodTruck:0x00007fe134910650...>]
  #   },
  # }

pry(main)> event.overstocked_items
#=> [#<Item:0x007f9c56740d48...>]

pry(main)> event.sorted_item_list
#=> ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]
```

## Iteration 4 - Selling Items

Add a method to your Event class called `sell` that takes an item and a quantity as arguments. There are two possible outcomes of the `sell` method:

1. If the Event does not have enough of the item in stock to satisfy the given quantity, this method should return `false`.

2. If the Event's has enough of the item in stock to satisfy the given quantity, this method should return `true`. Additionally, this method should reduce the stock of the FoodTrucks. It should look through the FoodTrucks in the order they were added and sell the item from the first FoodTruck with that item in stock. If that FoodTruck does not have enough stock to satisfy the given quantity, the FoodTruck's entire stock of that item will be depleted, and the remaining quantity will be sold from the next food_truck with that item in stock. It will follow this pattern until the entire quantity requested has been sold.

For example, suppose food_truck1 has 35 `peach pies` and food_truck3 has 65 `peach pies`, and food_truck1 was added to the event first. If the method `sell(<ItemXXX, @name = 'Peach Pie'...>, 40)` is called, the method should return `true`, food_truck1's new stock of `peach pies` should be 0, and food_truck3's new stock of `peach pies` should be 60.

Use TDD to update the `Event` class so that it responds to the following interaction pattern:

```ruby
pry(main)> require 'date'
#=> true

pry(main)> require './lib/item'
#=> true

pry(main)> require './lib/food_truck'
#=> true

pry(main)> require './lib/event'
#=> true

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
#=> #<Item:0x007f9c562a5f18...>

pry(main)> item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
#=> #<Item:0x007f9c56343038...>

pry(main)> item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
#=> #<Item:0x007f9c561636c8...>

pry(main)> event = Event.new("South Pearl Street Farmers Market")
#=> #<Event:0x00007fe134933e20...>

pry(main)> event.date
#=> "24/02/2020"

# A event will now be created with a date - whatever date the event is created on through the use of `Date.today`. The addition of a date to the event should NOT break any previous tests.  The `date` method will return a string representation of the date - 'dd/mm/yyyy'. We want you to test this in with a date that is IN THE PAST. In order to test the date method in a way that will work today, tomorrow and on any date in the future, you will need to use a stub :)

pry(main)> food_truck1 = FoodTruck.new("Rocky Mountain Pies")
#=> #<FoodTruck:0x00007fe1348a1160...>

pry(main)> food_truck1.stock(item1, 35)

pry(main)> food_truck1.stock(item2, 7)

pry(main)> food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
#=> #<FoodTruck:0x00007fe1349bed40...>

pry(main)> food_truck2.stock(item4, 50)

pry(main)> food_truck2.stock(item3, 25)

pry(main)> food_truck3 = FoodTruck.new("Palisade Peach Shack")
#=> #<FoodTruck:0x00007fe134910650...>

pry(main)> food_truck3.stock(item1, 65)

pry(main)> event.add_food_truck(food_truck1)

pry(main)> event.add_food_truck(food_truck2)

pry(main)> event.add_food_truck(food_truck3)

pry(main)> event.sell(item1, 200)
#=> false

pry(main)> event.sell(item5, 1)
#=> false

pry(main)> event.sell(item4, 5)
#=> true

pry(main)> food_truck2.check_stock(item4)
#=> 45

pry(main)> event.sell(item1, 40)
#=> true

pry(main)> food_truck1.check_stock(item1)
#=> 0

pry(main)> food_truck3.check_stock(item1)
#=> 60
```

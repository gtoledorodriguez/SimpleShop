desc "Generate sample data for testing"
task sample_data: :environment do
  require "faker"

  puts "Clearing old data..."
  Sale.delete_all
  Item.delete_all
  Business.delete_all
  User.delete_all

  puts "Creating users..."
  user_names = %w[Alice Bob Carol Dave Eve]
  users = user_names.map do |name|
    User.create!(
      name: name,
      email: "#{name.downcase}@example.com",
      password: "appdev",
      password_confirmation: "appdev",
    )
  end

  # Add Lydia
  lydia = User.create!(
    name: "Lydia",
    email: "lydia@example.com",
    password: "appdev",
    password_confirmation: "appdev",
  )
  users << lydia

  puts "Creating businesses, items and sales for main users..."
  users[0..-2].each do |user|   # all except Lydia
    business = Business.create!(
      name: "#{user.name}'s #{Faker::Company.industry}",
      owner: user,
    )

    rand(3..6).times do
      stock = rand(0..20)  # initial stock
      item = business.items.create!(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 5..100),
        quantity_in_stock: stock,
        low_stock_threshold: rand(3..7),
      )

      remaining_stock = item.quantity_in_stock
      rand(1..5).times do
        break if remaining_stock <= 0

        quantity = rand(1..[ 3, remaining_stock ].min)
        sale = Sale.create!(
          item: item,
          user: user,
          quantity_sold: quantity,
          created_at: rand(0..7).days.ago + rand(0..23).hours + rand(0..59).minutes,
        )

        remaining_stock -= quantity
        item.update!(quantity_in_stock: remaining_stock)
      end
    end
  end

  puts "Creating Lydia's corner store..."
  corner_store = Business.create!(
    name: "Lydia's Corner Store",
    owner: lydia,
  )

  # Realistic corner store items
  corner_items = [
    { name: "Milk (1L)", price: 2.99, stock: 20 },
    { name: "Bread", price: 1.50, stock: 30 },
    { name: "Eggs (12-pack)", price: 3.50, stock: 15 },
    { name: "Apples (per lb)", price: 1.20, stock: 25 },
    { name: "Coffee (12 oz)", price: 5.99, stock: 10 },
    { name: "Cereal", price: 4.50, stock: 12 },
    { name: "Chips", price: 2.25, stock: 18 }
  ]

  corner_items.each do |item_data|
    item = corner_store.items.create!(
      name: item_data[:name],
      price: item_data[:price],
      quantity_in_stock: item_data[:stock],
      low_stock_threshold: [ 2, 3, 5 ].sample
    )

    # Optional: generate a few sales for Lydia's items
    remaining_stock = item.quantity_in_stock
    rand(1..3).times do
      break if remaining_stock <= 0

      quantity = rand(1..[ 3, remaining_stock ].min)
      Sale.create!(
        item: item,
        user: lydia,
        quantity_sold: quantity,
        created_at: rand(0..7).days.ago + rand(0..23).hours + rand(0..59).minutes
      )
      remaining_stock -= quantity
      item.update!(quantity_in_stock: remaining_stock)
    end
  end

  puts "Sample data created successfully!"
  puts "Users created: #{User.count}"
  puts "Businesses created: #{Business.count}"
  puts "Items created: #{Item.count}"
  puts "Sales created: #{Sale.count}"
end

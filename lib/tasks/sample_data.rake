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
      password_confirmation: "appdev"
    )
  end

  puts "Creating businesses, items and sales..."
  users.each do |user|
    business = Business.create!(
      name: "#{user.name}'s #{Faker::Company.industry}",
      owner: user
    )

    rand(3..6).times do
      item = business.items.create!(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 5..100),
        quantity_in_stock: rand(0..20),
        low_stock_threshold: rand(3..7)
      )

      # Create some sales for the item
      rand(1..5).times do
        quantity = rand(1..3)
        Sale.create!(
          item: item,
          user: users.sample,
          quanitity_sold: quantity,
          total_price: item.price * quantity
        )
      end
    end
  end

  puts "Sample data created successfully!"
  puts "Users created: #{User.count}"
  puts "Businesses created: #{Business.count}"
  puts "Items created: #{Item.count}"
  puts "Sales created: #{Sale.count}"
end

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
      stock = rand(0..20)  # initial stock
      item = business.items.create!(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 5..100),
        quantity_in_stock: stock,
        low_stock_threshold: rand(3..7)
      )

      # Generate sales respecting stock
      remaining_stock = item.quantity_in_stock
      rand(1..5).times do
        break if remaining_stock <= 0

        quantity = rand(1..[3, remaining_stock].min) # can't sell more than stock
        sale = Sale.create!(
          item: item,
          user: user,              # owner of the business
          quantity_sold: quantity
        )

        # Reduce stock to avoid validation errors
        remaining_stock -= quantity
        item.update!(quantity_in_stock: remaining_stock)
      end
    end
  end

  puts "Sample data created successfully!"
  puts "Users created: #{User.count}"
  puts "Businesses created: #{Business.count}"
  puts "Items created: #{Item.count}"
  puts "Sales created: #{Sale.count}"
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'date'

desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  starting = Time.now

  # Role sample data
  roles = ["Beauty Advisor", "Operations Associate", "Lead", "Manager"]
  roles.each do |role|
    Role.find_or_create_by(title: role)
  end

  # Shop sample data
  shops = [
    { shop_number: 336 , address: "605 Michigan Ave, Chicago, IL 60611" , at_kohls: false },
    { shop_number: 200 , address: "9350 Joliet Rd, Hodgkins, IL 60525" , at_kohls: true },
    { shop_number: 173, address: "582 Village Center Dr Suite 220, Burr Ridge, IL 60527" , at_kohls: false },
    { shop_number: 544, address: "3405 N Southport Ave, Chicago, IL 60657" , at_kohls: false },
    { shop_number: 189, address: "104 Oakbrook Center, Oak Brook, IL 60523" , at_kohls: false}
  ]
  shops.each do |shop|
    Shop.find_or_create_by(shop_number: shop[:shop_number]) do |s|
      s.address = shop[:address]
      s.at_kohls = shop[:at_kohls]
    end
  end

  # Employee sample data
  employees = Array.new(9) do
    { first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name}
  end

  # Add one specific employee that I'll be using to test application
  employees << { first_name: "Daisy", last_name: "Salgado" }

  employee_numbers = [372976, 237932, 297826, 370701, 349928, 280626, 418626, 171581, 221769, 308370]
  employees.each do |employee|
    employee_number = employee_numbers.sample
    employee_numbers.delete(employee_number)

    Employee.find_or_create_by(
      first_name: employee[:first_name].capitalize,
      last_name: employee[:last_name].capitalize,
      employee_number: employee_number
    ) do |e|
      e.email = "#{employee[:first_name].downcase}@sephora.com"
      e.password = "password"
      e.role_id = Role.pluck(:id).sample
      e.shop_id = Shop.pluck(:id).sample
    end
  end

  # Brand sample data
  brands = ["Dior", "Merit", "Phlur", "Pattern", "The Inkey List", "Paco Rabanne", "One/Size", "Laura Mercier", "Ceremonia", "Haus Labs"]
  brands.each do |brand|
    Brand.find_or_create_by(name: brand)
  end

  # Department sample data
  departments = ["Makeup", "Skincare", "Hair", "Fragrance"]
  departments.each do |department|
    Department.find_or_create_by(name: department)
  end

  # Product sample data
  products = [
    { name: "Miss Dior Blooming Bouquet EDP 3.4oz", brand_name: "Dior", department_name: "Fragrance", image: "products/dior blooming bouquet 3.4.webp", sku: 2467371 },
    { name: "The Minimalist Perfecting Complexion Foundation and Concealer Stick - Suede Medium Neutral", brand_name: "Merit", department_name: "Makeup", image: "products/merit foundation suede medium neutral.webp", sku: 2743896 },
    { name: "Not Your Baby EDP 1.7oz", brand_name: "Phlur", department_name: "Fragrance", image: "products/phlur not your baby edp 1.7.webp", sku: 2568376 },
    { name: "Leave-In Conditioner for Curls and Coils 9.8oz", brand_name: "Pattern", department_name: "Hair", image: "products/pattern leave-in conditioner.webp", sku: 2494367 },
    { name: "Oat Makeup Removing Cleansing Balm 5oz", brand_name: "The Inkey List", department_name: "Skincare", image: "products/the inkey list oat cleansing balm.webp", sku: 2335636 },
    { name: "Invictus EDT 3.4oz", brand_name: "Paco Rabanne", department_name: "Fragrance", image: "products/paco rabanne invictus edt 3.4.webp", sku: 1605906 },
    { name: "On 'Til Dawn Mattifying Waterproof Setting Spray 3.4oz", brand_name: "One/Size", department_name: "Makeup", image: "products/one size setting spray 3.4.webp", sku: 2490696 },
    { name: "Translucent Loose Setting Powder 1oz", brand_name: "Laura Mercier", department_name: "Makeup", image: "products/laura mercier translucent loose setting powder.webp", sku: 870618 },
    { name: "Guava Hydrating Leave-In Conditioner 6.7oz", brand_name: "Ceremonia", department_name: "Hair", image: "products/ceremonia guava leave-in conditioner.webp", sku: 2605178 },
    { name: "Triclone Skin Tech Hydrating + De-puffing Concealer - 31 Medium Neutral", brand_name: "Haus Labs", department_name: "Makeup", image: "products/haus labs concealer 31 medium neutral.webp", sku: 2696821 }
  ]

  products.each do |product|
    brand = Brand.find_by(name: product[:brand_name])
    department = Department.find_by(name: product[:department_name])

    Product.find_or_create_by(sku: product[:sku]) do |p|
      p.name = product[:name]
      p.brand_id = brand.id
      p.image = product[:image]
      p.department_id = department.id
    end
  end

  # Tester sample data
  testers = []
  Product.all.sample(5).each do |product|
    testers << {
      product_id: product.id,
      shop_id: Shop.pluck(:id).sample,
      condition: ["new", "good", "ok", "replace"].sample.capitalize,
      trashed_at: Faker::Time.backward(days: 365, period: :all).to_datetime
    }
  end

  testers.each do |tester|
    Tester.find_or_create_by(product_id: tester[:product_id], shop_id: tester[:shop_id]) do |t|
      t.condition = tester[:condition].capitalize
      t.trashed_at = tester[:trashed_at]
    end
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{Employee.count} employees."
  p "There are now #{Brand.count} brands."
  p "There are now #{Department.count} departments."
  p "There are now #{Role.count} roles."
  p "There are now #{Shop.count} shops."
  p "There are now #{Product.count} products."
  p "There are now #{Tester.count} testers."
end

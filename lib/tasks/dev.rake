desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  Brand.delete_all
  Department.delete_all
  Employee.delete_all
  Product.delete_all
  Role.delete_all
  Shop.delete_all
  Tester.delete_all

  #Employee sample data
  employees = Array.new(9) do
    { first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name}
  end

  #Add one specific employee that I'll be using to test application
  employees << { first_name: "Daisy", last_name: "Salgado" }

  employee_numbers = [372976, 237932, 297826, 370701, 349928, 280626, 418626, 171581, 221769, 308370 ]
  employees.each do |employee|
    employee_number=employee_numbers.sample()
    employee_numbers.delete(employee_number)

    employee = Employee.create(
      first_name: employee[:first_name].capitalize,
      last_name: employee[:last_name].capitalize,
      employee_number: employee_number,
      email: "#{employee[:first_name].downcase}@sephora.com",
      password: "password",
      role_id: Role.pluck(:id).sample,
      shop_id:Shop.pluck(:id).sample
    )
  end

  # Brand sample data
  brands = ["Dior", "Merit", "Phlur", "Pattern", "The Inkey List", "Paco Rabanne", "One/Size", "Laura Mercier", "Ceremonia", "Haus Labs"]
  brands.each do |brand|
    Brand.create(
      name: brand
    )
  end

  # Department sample data
  departments = ["Makeup", "Skincare", "Hair", "Fragrance"]
  departments.each do |department|
    Department.create(
      name: department
    )
  end

  # Role sample data
  roles = ["Beauty Advisor", "Operations Associate", "Lead", "Manager"]
  roles.each do |role|
    Role.create(
      title: role
    )
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
    Shop.create(
      shop_number: shop[:shop_number],
      address: shop[:address],
      at_kohls: shop[:at_kohls]
    )
  end

  #Product sample data
  products = [
  {name: "Miss Dior Blooming Bouquet EDP 3.4oz", brand_id: 1, image: "products/dior blooming bouquet 3.4.webp", department_id: 4, sku: 2467371 },
  {name: "The Minimalist Perfecting Complexion Foundation and Concealer Stick - Suede Medium Neutral", brand_id: 2 , image: "products/merit foundation suede medium neutral.webp", department_id: 1, sku: 2743896 },
  {name: "Not Your Baby EDP 1.7oz", brand_id: 3 , image: "products/phlur not your baby edp 1.7.webp", department_id: 4, sku: 2568376 },
  {name: "Leave-In Conditioner for Curls and Coils 9.8oz", brand_id: 4 , image: "products/pattern leave-in conditioner.webp", department_id: 3, sku: 2494367 },
  {name: "Oat Makeup Removing Cleansing Balm 5oz", brand_id: 5 , image: "products/the inkey list oat cleansing balm.webp", department_id: 2, sku: 2335636 },
  {name: "Invictus EDT 3.4oz", brand_id: 6 , image: "products/paco rabanne invictus edt 3.4.webp", department_id: 4, sku: 1605906 },
  {name: "On 'Til Dawn Mattifying Waterproof Setting Spray 3.4oz", brand_id: 7 , image: "products/one size setting spray 3.4.webp", department_id: 1, sku: 2490696 },
  {name: "Translucent Loose Setting Powder 1oz", brand_id: 8 , image: "products/laura mercier translucent loose setting powder.webp", department_id: 1, sku: 870618 },
  {name: "Guava Hydrating Leave-In Conditioner 6.7oz", brand_id: 9 , image: "products/ceremonia guava leave-in conditioner.webp", department_id: 3, sku: 2605178 },
  {name: "Triclone Skin Tech Hydrating + De-puffing Concealer - 31 Medium Neutral", brand_id: 10 , image: "products/haus labs concealer 31 medium neutral.webp", department_id: 1, sku: 2696821 }
  ]

  products.each do |product|
    Product.create(
      name: product[:name],
      brand_id: product[:brand_id],
      image: product[:image],
      department_id: product[:department_id],
      sku: product[:sku]
    )
  end

  #Tester sample data

  testers = []
  Product.all.sample(5).each do |product|
    testers << {
      product_id: product.id,
      shop_id: Shop.pluck(:id).sample,
      condition: ["new", "good", "ok", "replace"].sample.capitalize
    }
  end

  testers.each do |tester|
    Tester.create(
      product_id: tester[:product_id],
      shop_id: tester[:shop_id],
      condition: tester[:condition].capitalize
    )
  end
end

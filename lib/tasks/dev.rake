require 'date'
desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  starting = Time.now

  Employee.delete_all
  # Tester.delete_all
  Product.delete_all
  Brand.delete_all
  Department.delete_all
  Role.delete_all
  Shop.delete_all
  
   # Role sample data
  roles = ["Beauty Advisor", "Operations Associate", "Lead", "Manager", "Admin"]
  roles.each do |role|
    Role.create(
      title: role
    )
  end

  #seperate this static data to a csv
 
   # Shop sample data
  shops = [
  { shop_number: 336 , address: "605 Michigan Ave, Chicago, IL 60611" , at_kohls: false },
  { shop_number: 200 , address: "9350 Joliet Rd, Hodgkins, IL 60525" , at_kohls: true },
  { shop_number: 173, address: "582 Village Center Dr Suite 220, Burr Ridge, IL 60527" , at_kohls: false },
  { shop_number: 544, address: "3405 N Southport Ave, Chicago, IL 60657" , at_kohls: false },
  { shop_number: 189, address: "104 Oakbrook Center, Oak Brook, IL 60523" , at_kohls: false},
  { shop_number: 111, address: "Sephora Headquarters" , at_kohls: false}
  ]
  shops.each do |shop|
    Shop.create(
      shop_number: shop[:shop_number],
      address: shop[:address],
      at_kohls: shop[:at_kohls]
    )
  end
 
  # Employee sample data
  employees = [
    { first_name: "Daisy", last_name: "Salgado", employee_number: 356177, email: "daisy@sephora.com", password: "password", role_id: Role.find_by(title: "Operations Associate").id, shop_id: Shop.find_by(shop_number: 336).id, admin: false },
    { first_name: "Kevin", last_name: "Brown", employee_number: 111111, email: "kevin@sephora.com", password: "password", role_id: Role.find_by(title: "Lead").id, shop_id: Shop.find_by(shop_number: 200).id, admin: false },
    { first_name: "Mateo", last_name: "Hernandez", employee_number: 222222, email: "mateo@sephora.com", password: "password", role_id: Role.find_by(title: "Beauty Advisor").id, shop_id: Shop.find_by(shop_number: 173).id, admin: false },
    { first_name: "Itzel", last_name: "Romero", employee_number: 333333, email: "itzel@sephora.com", password: "password", role_id: Role.find_by(title: "Manager").id, shop_id: Shop.find_by(shop_number: 544).id, admin:false },
    { first_name: "Liam", last_name: "Williams", employee_number: 444444, email: "liam@sephora.com", password: "password", role_id: Role.find_by(title: "Beauty Advisor").id, shop_id: Shop.find_by(shop_number: 336).id, admin: false },
    { first_name: "Emma", last_name: "Johnson", employee_number: 555555, email: "emma@sephora.com", password: "password", role_id: Role.find_by(title: "Operations Associate").id, shop_id: Shop.find_by(shop_number: 200).id, admin: false },
    { first_name: "Ethan", last_name: "Martinez", employee_number: 666666, email: "ethan@sephora.com", password: "password", role_id: Role.find_by(title: "Manager").id, shop_id: Shop.find_by(shop_number: 173).id, admin: false },
    { first_name: "Ava", last_name: "Miller", employee_number: 777777, email: "ava@sephora.com", password: "password", role_id: Role.find_by(title: "Lead").id, shop_id: Shop.find_by(shop_number: 544).id, admin: false },
    { first_name: "Noah", last_name: "Davis", employee_number: 888888, email: "noah@sephora.com", password: "password", role_id: Role.find_by(title: "Beauty Advisor").id, shop_id: Shop.find_by(shop_number: 189).id, admin: false },
    { first_name: "Sophia", last_name: "Garcia", employee_number: 999999, email: "sophia@sephora.com", password: "password", role_id: Role.find_by(title: "Operations Associate").id, shop_id: Shop.find_by(shop_number: 189).id, admin: false},
    { first_name: "Admin", last_name: "Sephora", employee_number: 100000, email: "admin@sephora.com", password: "password", role_id: Role.find_by(title: "Admin").id, shop_id: Shop.find_by(shop_number: 111).id, admin: true}
  ]
  employees.each do |employee|
    Employee.create(
      first_name: employee[:first_name].capitalize,
      last_name: employee[:last_name].capitalize,
      employee_number: employee[:employee_number],
      email: employee[:email],
      password: employee[:password],
      role_id: employee[:role_id],
      shop_id: employee[:shop_id],
      admin: employee[:admin]
    )
  end

  # Brand sample data
  brands = ["Dior", "Merit", "Phlur", "Pattern", "The Inkey List", "Paco Rabanne", "One/Size", "Laura Mercier", "Ceremonia", "Haus Labs", "Charlotte Tilbury", "Summer Fridays", "Tower 28 Beauty", "Benefit Cosmetics", "Dae", "Glossier", "Gucci", "Fenty Beauty", "Youth To The People", "The Ordinary" ]
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

  # Product sample data
  products = [
    { name: "Miss Dior Blooming Bouquet EDP 3.4oz", brand_name: "Dior", department_name: "Fragrance", image: "products/dior blooming bouquet 3.4.webp", sku: "2467371" },
    { name: "The Minimalist Perfecting Complexion Foundation and Concealer Stick - Suede Medium Neutral", brand_name: "Merit", department_name: "Makeup", image: "products/merit foundation suede medium neutral.webp", sku: "2743896" },
    { name: "Not Your Baby EDP 1.7oz", brand_name: "Phlur", department_name: "Fragrance", image: "products/phlur not your baby edp 1.7.webp", sku: "2568376" },
    { name: "Leave-In Conditioner for Curls and Coils 9.8oz", brand_name: "Pattern", department_name: "Hair", image: "products/pattern leave-in conditioner.webp", sku: "2494367" },
    { name: "Oat Makeup Removing Cleansing Balm 5oz", brand_name: "The Inkey List", department_name: "Skincare", image: "products/the inkey list oat cleansing balm.webp", sku: "2335636" },
    { name: "Invictus EDT 3.4oz", brand_name: "Paco Rabanne", department_name: "Fragrance", image: "products/paco rabanne invictus edt 3.4.webp", sku: "1605906" },
    { name: "On 'Til Dawn Mattifying Waterproof Setting Spray 3.4oz", brand_name: "One/Size", department_name: "Makeup", image: "products/one size setting spray 3.4.webp", sku: "2490696" },
    { name: "Translucent Loose Setting Powder 1oz", brand_name: "Laura Mercier", department_name: "Makeup", image: "products/laura mercier translucent loose setting powder.webp", sku: "870618" },
    { name: "Guava Hydrating Leave-In Conditioner 6.7oz", brand_name: "Ceremonia", department_name: "Hair", image: "products/ceremonia guava leave-in conditioner.webp", sku: "2605178" },
    { name: "Triclone Skin Tech Hydrating + De-puffing Concealer - 31 Medium Neutral", brand_name: "Haus Labs", department_name: "Makeup", image: "products/haus labs concealer 31 medium neutral.webp", sku: "2696821" },
    { name: "Airbrush Flawless Waterproof Setting Spray 3.3oz", brand_name: "Charlotte Tilbury", department_name: "Makeup", image: "products/charlotte tilbury setting spray.webp", sku: "2368439" },
    { name: "Lip Butter Balm for Hydration & Shine - Hot Cocoa", brand_name: "Summer Fridays", department_name: "Skincare", image: "products/summer fridays hot cocoa.webp", sku: "2802163" },
    { name: "SOS Daily Rescue Facial Spray with Hypochlorous Acid 4oz", brand_name: "Tower 28 Beauty", department_name: "Skincare", image: "products/tower 28 spray.webp", sku: "2527844" },
    { name: "Hoola Matte Powder Bronzer - Hoola", brand_name: "Benefit Cosmetics", department_name: "Makeup", image: "products/benefit hoola bronzer.webp", sku: "2520427" },
    { name: "Cactus Fruit 3-in-1 Styling Cream 5oz", brand_name: "Dae", department_name: "Hair", image: "products/dae styling cream.webp", sku: "2539542" },
    { name: "Glossier You Doux EDP", brand_name: "Glossier", department_name: "Fragrance", image: "products/glossier doux edp.webp", sku: "2819274" },
    { name: "Flora Gorgeous Orchid EDP 3.3oz", brand_name: "Gucci", department_name: "Fragrance", image: "products/gucci flora yellow.webp", sku: "2788149" },
    { name: "Gloss Bomb Universal Lip Luminizer - Riri", brand_name: "Fenty Beauty", department_name: "Makeup", image: "products/fenty riri gloss.webp", sku: "2662468" },
    { name: "Superfood Gentle Antioxidant Refillable Cleanser 8oz", brand_name: "Youth To The People", department_name: "Skincare", image: "products/yttp superfood cleanser.webp", sku: "1863588" },
    { name: "Multi-Peptide Serum for Hair Density 2oz", brand_name: "The Ordinary", department_name: "Hair", image: "products/the ordinary hair serum.webp", sku: "2210722" }
  ]

  products.each do |product|
    brand = Brand.find_by(name: product[:brand_name]) 
    department = Department.find_by(name: product[:department_name])

      Product.create(
        name: product[:name],
        brand_id: brand.id,
        image: product[:image],
        department_id: department.id,
        sku: product[:sku]
      )
  end

  # Tester sample data
  Shop.all.each do |shop|
    testers = [
      { product_id: Product.find_by(sku: "2467371").id, condition: "New", location: "Onstage", trashed_at: nil },
      { product_id: Product.find_by(sku: "2743896").id, condition: "Ok", location: "Makeup Bin 2", trashed_at: nil },
      { product_id: Product.find_by(sku: "2568376").id, condition: "Good", location: "Fragrance Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2494367").id, condition: "Ok", location: "Hair Bin 2", trashed_at: nil },
      { product_id: Product.find_by(sku: "2335636").id, condition: "New", location: "Skincare Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "1605906").id, condition: "Good", location: "Fragrance Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2490696").id, condition: "Good", location: "Makeup Bin 2", trashed_at: nil },
      { product_id: Product.find_by(sku: "870618").id, condition: "Ok", location: "Makeup Bin 2", trashed_at: nil },
      { product_id: Product.find_by(sku: "2605178").id, condition: "Ok", location: "Hair Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2696821").id, condition: "New", location: "Makeup Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2802163").id, condition: "New", location: "Onstage", trashed_at: nil },
      { product_id: Product.find_by(sku: "2527844").id, condition: "Ok", location: "Skincare Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2520427").id, condition: "Good", location: "Makeup Bin 1", trashed_at: nil },
      { product_id: Product.find_by(sku: "2819274").id, condition: "Good", location: "Fragrance Bin 2", trashed_at: nil },
      { product_id: Product.find_by(sku: "2662468").id, condition: "Good", location: "Makeup Bin 1", trashed_at: nil }
    ]
  
    # Add additional random testers
    Product.all.sample(15).each do |product|
      if product.department.name == "Makeup"
        tester_location = ["Onstage", "Makeup Bin 1", "Makeup Bin 2"].sample
      elsif product.department.name == "Skincare"
        tester_location = ["Onstage", "Skincare Bin 1", "Skincare Bin 2"].sample
      elsif product.department.name == "Hair"
        tester_location = ["Onstage", "Hair Bin 1", "Hair Bin 2"].sample
      elsif product.department.name == "Fragrance"
        tester_location = ["Onstage", "Fragrance Bin 1", "Fragrance Bin 2"].sample
      else
        tester_location = "Onstage"
      end
  
      testers << {
        product_id: product.id,
        condition: ["New", "Good", "Ok"].sample, 
        location: tester_location,
        trashed_at: [nil, Faker::Time.backward(days: 365, period: :all).to_datetime.strftime("%B %d, %Y %H:%M:%S")].sample
      }
    end
  
    # Create testers for this specific shop
    testers.each do |tester|
      Tester.create(
        product_id: tester[:product_id],
        shop_id: shop.id,
        condition: tester[:condition],
        location: tester[:location],
        created_at: Faker::Time.backward(days: 365, period: :all).to_datetime.strftime("%B %d, %Y %H:%M:%S"),
        trashed_at: tester[:trashed_at]
      )
    end
  end

  # Print information on sample data created
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

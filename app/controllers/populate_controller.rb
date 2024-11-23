# app/controllers/populate_controller.rb

class PopulateController < ApplicationController
  def populate
    if Rails.env.production?
      # Role sample data
      roles = ["Beauty Advisor", "Operations Associate", "Lead", "Manager"]
      roles.each do |role|
        Role.find_or_create_by!(title: role)
      end

      # Shop sample data
      shops = [
        { shop_number: 336 , address: "605 Michigan Ave, Chicago, IL 60611" , at_kohls: false },
        { shop_number: 200 , address: "9350 Joliet Rd, Hodgkins, IL 60525" , at_kohls: true },
        { shop_number: 173, address: "582 Village Center Dr Suite 220, Burr Ridge, IL 60527" , at_kohls: false },
        { shop_number: 544, address: "3405 N Southport Ave, Chicago, IL 60657" , at_kohls: false },
        { shop_number: 189, address: "104 Oakbrook Center, Oak Brook, IL 60523" , at_kohls: false }
      ]
      shops.each do |shop|
        Shop.find_or_create_by!(shop_number: shop[:shop_number]) do |s|
          s.address = shop[:address]
          s.at_kohls = shop[:at_kohls]
        end
      end

      render plain: "Roles and shops populated successfully!"
    else
      render plain: "This action is only available in production."
    end
  end
end

require 'pry'

def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1 
  end
  nil 
end

def consolidate_cart(cart)
  new_cart = []
  hash = {}
  i = 0 
  while i < cart.length do # loop through cart
    hash = cart[i]
    if !hash[:count]
      hash[:count] = 1
    else
      hash[:count] += 1 
    end
    new_cart << hash 
    i += 1 
  end
  new_cart.uniq 
end

def apply_coupons(cart, coupons)
  coupons.uniq.each do |coupon|
    hash = {}
    item = coupon[:item]
    num = coupon[:num]
    price = coupon[:cost]/num 
    i = 0 
    while i < cart.length do 
      if cart[i][:item] == item
        hash[:item] = "#{item} W/COUPON"
        hash[:price] = price
        clearance = cart[i][:clearance]
        hash[:clearance] = clearance
        hash[:count] = num
        cart[i][:count] -= num 
      end
      i += 1 
    end 
    cart << hash
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true 
      item[:price] -= item[:price] * 0.2
      (item[:price]).round(2)
    end 
  end
end

def checkout(array, coupons)
  
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = 0 
  applied_discount.each do |item|
    if item[:count] > 0 
      total += item[:price]*item[:count]
    end
  end
  binding.pry
  total > 100 ? total * 0.9 : total
end

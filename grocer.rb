require 'pry'

def consolidate_cart(cart)
my_hash = {}
  cart.each do |hash|
    hash.each do |item, data|
      if my_hash[item] == nil
        my_hash[item] = data
        my_hash[item][:count] = 1
      else
        my_hash[item][:count] += 1
      end
    end
  end
  my_hash
end
  
def apply_coupons(cart, coupons)
  coupon_hash = {}
  cart.each do |key, value|
    coupon_hash[key] = value.clone
    coupons.each do |coupon|
      if coupon[:item] == key
        coupon_hash[key][:count] = value[:count]%coupon[:num]
        coupon_hash[key + " W/COUPON"] = value.clone
        coupon_hash[key + " W/COUPON"][:count] = value[:count] / coupon[:num]
        coupon_hash[key + " W/COUPON"][:price] = coupon[:cost]
      end
    end
  end
  coupon_hash
end

def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |item,details|
    if cart[item][:clearance]
      clearance_cart[item] = {
        price: (details[:price] * 0.80).round(1),
        clearance: true,
        count: details[:count]
      }
    else
      clearance_cart[item] = details.clone
    end
  end
  clearance_cart
end

def checkout(cart, coupons)
  cart_tot = 0
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  final_cart.each do |item,details|
    cart_tot += details[:price] * details[:count]
  end
  return (cart_tot * 0.90).round(1) if cart_tot > 100 
  cart_tot
end

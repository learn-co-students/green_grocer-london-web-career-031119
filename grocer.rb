require 'pry'

def consolidate_cart(cart)
  # initialize resulting hash
  result = {}

  # go over the cart to populate resulting hash
  cart.each { |item_hash|
    item_hash.each { |item, stats|
      if !result.has_key?(item)
        result[item] = stats
        result[item][:count] = 1
      else
        result[item][:count] += 1
      end
    }
  }

  result

end

def apply_coupons(cart, coupons)
  # initialize hash for the updated cart
  result = cart

  # deal with each coupon individually.
  coupons.each { |coupon|
    # to simplify things we store coupon[:item] as just item (string)
    item = coupon[:item]
    # does the cart have the item AND do we have enough items
    # in cart for the coupon offer?
    if result.has_key?(item) && result[item][:count] >= coupon[:num]
      # check if coupon used before, if so simply increment couponized item
      if result.has_key?(item + " W/COUPON")
        result[item + " W/COUPON"][:count] += 1
      # otherwise create the entry with proper format
      else
        result[item + " W/COUPON"] = {
          price: coupon[:cost],
          clearance: result[item][:clearance],
          count: 1
        }
      end
      # remove coupon quantity (:num) from non-discount item, OK to reach 0
      result[item][:count] -= coupon[:num]
    end
  }

  result

end

def apply_clearance(cart)

#  binding.pry

  cart.each { |item, details|
    details[:price] = (details[:price] * 0.8).round(2) if details[:clearance]
  }

end

def checkout(cart, coupons)
  # consolidate, apply coupons and clearance to the incoming cart
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart, coupons)
  final_cart = apply_clearance(final_cart)

  # calculate final cost
  grand_total = 0

  final_cart.each { |item, details|
    grand_total += details[:price] * details[:count]
  }

  # apply 10% discount if the total is over $100
  grand_total > 100 ? (grand_total * 0.9) : grand_total

end

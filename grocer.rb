require "pry"

cart =   [
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"KALE" => {:price => 3.00, :clearance => false}},
      {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
      {"ALMONDS" => {:price => 9.00, :clearance => false}},
      {"TEMPEH" => {:price => 3.00, :clearance => true}},
      {"CHEESE" => {:price => 6.50, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
      {"BEETS" => {:price => 2.50, :clearance => false}},
      {"SOY MILK" => {:price => 4.50, :clearance => true}}
    ]

coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 2, :cost => 15.00}
    ]

def consolidate_cart(cart)
  # code here
  new_hash = {}
  count = :count
  cart.each do |array|
    array.each do |product, specs|
      #if new_hash doesn't have product, means that we return the key once and the value once.
      if new_hash.has_key?(product) == false
        new_hash[product] = specs
        new_hash[product][count] = 1
      else
        new_hash[product][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  final_hash = cart
  # iterate through coupons to check if it has any item we have in our cart
  coupons.each do |coupon|
    # get the items in coupons to then compare them with the ones in cart
    item = coupon[:item]
    # check if final_hash has the item and if the count in the cart is >= of the coupon's number.
    if final_hash.has_key?(item) && final_hash[item][:count] >= coupon[:num]
      # if so, check if final_hashalready have the key W/COUPON
      if final_hash.has_key?(item + " W/COUPON")
        # if so, return the same key by incrementing the :count by 1
        final_hash[item + " W/COUPON"][:count] += 1
        # if final_hash doesn't have the W/COUPON key yet, return the proper format
      else
        final_hash[item + " W/COUPON"] =
          {
            price: coupon[:cost],
            clearance: final_hash[item][:clearance],
            count: 1
          }
        end
        # substract the number of coupons from the item count
        final_hash[item][:count] -= coupon[:num]
      end
    end
    final_hash
  end

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.0}]
# apply_coupons(cart, coupons)


def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    # check if the item's clearance detail is true
    if details[:clearance]
      # if so, set the details[:price] to 20%
      details[:price] = details[:price] - (details[:price] * 20) / 100
    end
  end
end
# apply_clearance(cart)

def checkout(cart, coupons)
  # code here
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart, coupons)
  final_cart = apply_clearance(final_cart)

  # Calculate the final cost
  final_cost = 0

  # iterate over final_cart and calculate the final_cost
  final_cart.each do |item, details|
    final_cost += details[:price] * details[:count]
  end
  final_cost

  # if the total is > $100, we give a 10% discount to the final_cost
  final_cost > 100 ? (final_cost * 0.9) : final_cost
end

# checkout(cart, coupons)

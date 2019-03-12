require 'pry'

def consolidate_cart(cart)
  new = Hash.new(0)
count = 0
cart.each do |hash|
  hash.each do |key, value|
    if new.key?(key)
      new[key][:count] += 1
    else
      new[key] = value
 new[key][:count] = 1

end
end
end
new
end

def apply_coupons(cart, coupons)

  coupons.each do |hash|
    if !cart.include?(hash[:item])
      break
    else
  item = hash[:item].dup
  new_item = hash[:item].dup
  new_item << " W/COUPON"
  cart[new_item] = {}
  cart[new_item][:price] = hash[:cost]
  cart[new_item][:clearance] = cart[item][:clearance]
  num = cart[item][:count]
  cart[new_item][:count] = num / hash[:num]
  cart[item][:count] = num % hash[:num]

end
end
 cart
end


cart1 = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>5}}



coupons1 = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
            # {:item=>"AVOCADO", :num=>2, :cost=>5.0}]

# {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>1},
#  "AVOCADO W/COUPON"=>{:price=>5.0, :clearance=>true, :count=>2}}

p apply_coupons(cart1, coupons1)

def apply_clearance(cart)
cart.each do |key, value|
if cart[key][:clearance] == true
  cart[key][:price] = (cart[key][:price] * 0.80).round(2)
end
end
cart
end

def checkout(cart, coupons)
newcart = consolidate_cart(cart)
newcart2 = apply_coupons(newcart)
discount = apply_clearance(newcart2)

p discount


end

def find_item_by_name_in_collection(name, collection)

  #collection.each do |items_hash| 
   # items_hash.each do |key, value|
    #    if value == name 
     #       return items_hash
      #  end
    #end 
#  end 
 # return nil 
 counter = 0 
 
 while counter < collection.length 
  if collection[counter][:item] == name
    return collection[counter]
  end 
  counter += 1
end
end 

def consolidate_cart(cart)
  new_cart = [ ]
  counter = 0 
   
  while counter < cart.length do 
  new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
   if new_cart_item  
      new_cart_item[:count] += 1 
    else 
      new_cart_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end 
    counter += 1 
  end 
  new_cart
end 


def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
         cart_item_with_coupon[:count] += coupons[counter][:num]
         cart_item[:count] -= coupons[counter][:num]
      else 
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
    end 
  end 
    counter += 1 
  end 
  cart 
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length 
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end 
      counter += 1
    end 
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidate_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidate_cart, coupons)
  final = apply_clearance(couponed_cart)
  
  total = 0 
  counter = 0
  
  while counter < final.length 
    total += final[counter][:price] * final[counter][:count]
    counter += 1
  end 
  if total > 100 
    total -= (total * 0.10)
  end 
  total 
end

require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    bakery_item = products(:bakery)

    get "/"
    assert_response :success
    assert_template "index"
    
    xml_http_request :post, '/line_items', :product_id => bakery_item.id
    assert_response :success 
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal bakery_item, cart.line_items[0].product
    
    get "/orders/new"
    assert_response :success
    assert_template "new"
    
    post_via_redirect "/orders",
                      :order => { :name     => "Charlie Day",
                                  :address  => "123 Chocolate Street",
                                  :email    => "charlieday@example.com",
                                  :pay_type => "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal "Charlie Day",      order.name
    assert_equal "123 Chocolate Street",   order.address
    assert_equal "charlieday@example.com", order.email
    assert_equal "Check",            order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal bakery_item, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["charlieday@example.com"], mail.to
    assert_equal 'Charlie Day <bakery@example.com>', mail[:from].value
    assert_equal "atebitbakery Order Confirmation", mail.subject
  end
end
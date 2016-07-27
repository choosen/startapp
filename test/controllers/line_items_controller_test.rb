require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)    
    @line_item_two = line_items(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item and go back" do
    links = Array.new(0,String)
    
    #links.insert 2, store_path
    #links.insert 1, carts_url
    links.insert 0, 'http://localhost/store'
       #%w(  store_path store_url carts_url )
    links.each do |link| 
      request.env["HTTP_REFERER"] = link
      assert_difference('LineItem.count', -1) do
        delete :destroy, id: @line_item
      end

      assert_redirected_to :back
    end
    
     request.env["HTTP_REFERER"] = carts_url
      assert_difference('LineItem.count', -1) do
        delete :destroy, id: @line_item_two 
      end

      assert_redirected_to :back
          
  end
end

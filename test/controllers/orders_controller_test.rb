require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success2
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success2
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { product_id: @order.product_id, product_name: @order.product_name, product_type: @order.product_type, product_value: @order.product_value }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success2
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success2
  end

  test "should update order" do
    patch :update, id: @order, order: { product_id: @order.product_id, product_name: @order.product_name, product_type: @order.product_type, product_value: @order.product_value }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end

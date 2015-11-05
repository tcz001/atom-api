require 'test_helper'

class LeaseOrdersControllerTest < ActionController::TestCase
  setup do
    @lease_order = lease_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lease_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lease_order" do
    assert_difference('LeaseOrder.count') do
      post :create, lease_order: { game_versions_id: @lease_order.game_versions_id, games_id: @lease_order.games_id, irb: @lease_order.irb, third_partys_id: @lease_order.third_partys_id }
    end

    assert_redirected_to lease_order_path(assigns(:lease_order))
  end

  test "should show lease_order" do
    get :show, id: @lease_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lease_order
    assert_response :success
  end

  test "should update lease_order" do
    patch :update, id: @lease_order, lease_order: { game_versions_id: @lease_order.game_versions_id, games_id: @lease_order.games_id, irb: @lease_order.irb, third_partys_id: @lease_order.third_partys_id }
    assert_redirected_to lease_order_path(assigns(:lease_order))
  end

  test "should destroy lease_order" do
    assert_difference('LeaseOrder.count', -1) do
      delete :destroy, id: @lease_order
    end

    assert_redirected_to lease_orders_path
  end
end

require 'test_helper'

class RefundOrdersControllerTest < ActionController::TestCase
  setup do
    @refund_order = refund_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:refund_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create refund_order" do
    assert_difference('RefundOrder.count') do
      post :create, refund_order: { customer_name: @refund_order.customer_name, mobile: @refund_order.mobile, payment_account: @refund_order.payment_account, status: @refund_order.status, third_party_id: @refund_order.third_party_id, third_pary_id: @refund_order.third_pary_id, why: @refund_order.why }
    end

    assert_redirected_to refund_order_path(assigns(:refund_order))
  end

  test "should show refund_order" do
    get :show, id: @refund_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @refund_order
    assert_response :success
  end

  test "should update refund_order" do
    patch :update, id: @refund_order, refund_order: { customer_name: @refund_order.customer_name, mobile: @refund_order.mobile, payment_account: @refund_order.payment_account, status: @refund_order.status, third_party_id: @refund_order.third_party_id, third_pary_id: @refund_order.third_pary_id, why: @refund_order.why }
    assert_redirected_to refund_order_path(assigns(:refund_order))
  end

  test "should destroy refund_order" do
    assert_difference('RefundOrder.count', -1) do
      delete :destroy, id: @refund_order
    end

    assert_redirected_to refund_orders_path
  end
end

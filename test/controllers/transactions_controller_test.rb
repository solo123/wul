require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success2
    assert_not_nil assigns(:transactions)
  end

  test "should get new" do
    get :new
    assert_response :success2
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, transaction: { account_after: @transaction.account_after, account_before: @transaction.account_before, frozen_after: @transaction.frozen_after, frozen_before: @transaction.frozen_before, operation_amount: @transaction.operation_amount, trans_type: @transaction.trans_type }
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should show transaction" do
    get :show, id: @transaction
    assert_response :success2
  end

  test "should get edit" do
    get :edit, id: @transaction
    assert_response :success2
  end

  test "should update transaction" do
    patch :update, id: @transaction, transaction: { account_after: @transaction.account_after, account_before: @transaction.account_before, frozen_after: @transaction.frozen_after, frozen_before: @transaction.frozen_before, operation_amount: @transaction.operation_amount, trans_type: @transaction.trans_type }
    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction
    end

    assert_redirected_to transactions_path
  end
end

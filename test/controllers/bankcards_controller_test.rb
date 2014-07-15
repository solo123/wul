require 'test_helper'

class BankcardsControllerTest < ActionController::TestCase
  setup do
    @bankcard = bankcards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bankcards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bankcard" do
    assert_difference('Bankcard.count') do
      post :create, bankcard: { bankname: @bankcard.bankname, cardid: @bankcard.cardid, user_id: @bankcard.user_id }
    end

    assert_redirected_to bankcard_path(assigns(:bankcard))
  end

  test "should show bankcard" do
    get :show, id: @bankcard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bankcard
    assert_response :success
  end

  test "should update bankcard" do
    patch :update, id: @bankcard, bankcard: { bankname: @bankcard.bankname, cardid: @bankcard.cardid, user_id: @bankcard.user_id }
    assert_redirected_to bankcard_path(assigns(:bankcard))
  end

  test "should destroy bankcard" do
    assert_difference('Bankcard.count', -1) do
      delete :destroy, id: @bankcard
    end

    assert_redirected_to bankcards_path
  end
end

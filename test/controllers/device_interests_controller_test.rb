require 'test_helper'

class DeviceInterestsControllerTest < ActionController::TestCase
  setup do
    @device_interest = device_interests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_interests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_interest" do
    assert_difference('DeviceInterest.count') do
      post :create, device_interest: { device_id: @device_interest.device_id, interest_id: @device_interest.interest_id }
    end

    assert_redirected_to device_interest_path(assigns(:device_interest))
  end

  test "should show device_interest" do
    get :show, id: @device_interest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_interest
    assert_response :success
  end

  test "should update device_interest" do
    patch :update, id: @device_interest, device_interest: { device_id: @device_interest.device_id, interest_id: @device_interest.interest_id }
    assert_redirected_to device_interest_path(assigns(:device_interest))
  end

  test "should destroy device_interest" do
    assert_difference('DeviceInterest.count', -1) do
      delete :destroy, id: @device_interest
    end

    assert_redirected_to device_interests_path
  end
end

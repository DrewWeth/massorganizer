require 'test_helper'

class DeviceSubmissionsControllerTest < ActionController::TestCase
  setup do
    @device_submission = device_submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_submission" do
    assert_difference('DeviceSubmission.count') do
      post :create, device_submission: { device_id: @device_submission.device_id, message: @device_submission.message }
    end

    assert_redirected_to device_submission_path(assigns(:device_submission))
  end

  test "should show device_submission" do
    get :show, id: @device_submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_submission
    assert_response :success
  end

  test "should update device_submission" do
    patch :update, id: @device_submission, device_submission: { device_id: @device_submission.device_id, message: @device_submission.message }
    assert_redirected_to device_submission_path(assigns(:device_submission))
  end

  test "should destroy device_submission" do
    assert_difference('DeviceSubmission.count', -1) do
      delete :destroy, id: @device_submission
    end

    assert_redirected_to device_submissions_path
  end
end

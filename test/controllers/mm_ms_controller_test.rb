require 'test_helper'

class MmMsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mmm = mmms(:one)
  end

  test "should get index" do
    get mmms_url
    assert_response :success
  end

  test "should get new" do
    get new_mmm_url
    assert_response :success
  end

  test "should create mmm" do
    assert_difference('Mmm.count') do
      post mmms_url, params: { mmm: {  } }
    end

    assert_redirected_to mmm_url(Mmm.last)
  end

  test "should show mmm" do
    get mmm_url(@mmm)
    assert_response :success
  end

  test "should get edit" do
    get edit_mmm_url(@mmm)
    assert_response :success
  end

  test "should update mmm" do
    patch mmm_url(@mmm), params: { mmm: {  } }
    assert_redirected_to mmm_url(@mmm)
  end

  test "should destroy mmm" do
    assert_difference('Mmm.count', -1) do
      delete mmm_url(@mmm)
    end

    assert_redirected_to mmms_url
  end
end

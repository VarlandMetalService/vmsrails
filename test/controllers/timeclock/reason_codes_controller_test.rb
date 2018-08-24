require 'test_helper'

class Timeclock::ReasonCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeclock_reason_code = timeclock_reason_codes(:one)
  end

  test "should get index" do
    get timeclock_reason_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_timeclock_reason_code_url
    assert_response :success
  end

  test "should create timeclock_reason_code" do
    assert_difference('Timeclock::ReasonCode.count') do
      post timeclock_reason_codes_url, params: { timeclock_reason_code: { description: @timeclock_reason_code.description, requires_note: @timeclock_reason_code.requires_note } }
    end

    assert_redirected_to timeclock_reason_code_url(Timeclock::ReasonCode.last)
  end

  test "should show timeclock_reason_code" do
    get timeclock_reason_code_url(@timeclock_reason_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_timeclock_reason_code_url(@timeclock_reason_code)
    assert_response :success
  end

  test "should update timeclock_reason_code" do
    patch timeclock_reason_code_url(@timeclock_reason_code), params: { timeclock_reason_code: { description: @timeclock_reason_code.description, requires_note: @timeclock_reason_code.requires_note } }
    assert_redirected_to timeclock_reason_code_url(@timeclock_reason_code)
  end

  test "should destroy timeclock_reason_code" do
    assert_difference('Timeclock::ReasonCode.count', -1) do
      delete timeclock_reason_code_url(@timeclock_reason_code)
    end

    assert_redirected_to timeclock_reason_codes_url
  end
end

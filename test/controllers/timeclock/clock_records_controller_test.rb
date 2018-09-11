require 'test_helper'

class Timeclock::ClockRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeclock_clock_record = timeclock_clock_records(:one)
  end

  test "should get index" do
    get timeclock_clock_records_url
    assert_response :success
  end

  test "should get new" do
    get new_timeclock_clock_record_url
    assert_response :success
  end

  test "should create timeclock_clock_record" do
    assert_difference('Timeclock::ClockRecord.count') do
      post timeclock_clock_records_url, params: { timeclock_clock_record: {  } }
    end

    assert_redirected_to timeclock_clock_record_url(Timeclock::ClockRecord.last)
  end

  test "should show timeclock_clock_record" do
    get timeclock_clock_record_url(@timeclock_clock_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_timeclock_clock_record_url(@timeclock_clock_record)
    assert_response :success
  end

  test "should update timeclock_clock_record" do
    patch timeclock_clock_record_url(@timeclock_clock_record), params: { timeclock_clock_record: {  } }
    assert_redirected_to timeclock_clock_record_url(@timeclock_clock_record)
  end

  test "should destroy timeclock_clock_record" do
    assert_difference('Timeclock::ClockRecord.count', -1) do
      delete timeclock_clock_record_url(@timeclock_clock_record)
    end

    assert_redirected_to timeclock_clock_records_url
  end
end

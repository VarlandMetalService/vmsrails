require 'test_helper'

class Timeclock::ClockPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeclock_clock_period = timeclock_clock_periods(:one)
  end

  test "should get index" do
    get timeclock_clock_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_timeclock_clock_period_url
    assert_response :success
  end

  test "should create timeclock_clock_period" do
    assert_difference('Timeclock::ClockPeriod.count') do
      post timeclock_clock_periods_url, params: { timeclock_clock_period: {  } }
    end

    assert_redirected_to timeclock_clock_period_url(Timeclock::ClockPeriod.last)
  end

  test "should show timeclock_clock_period" do
    get timeclock_clock_period_url(@timeclock_clock_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_timeclock_clock_period_url(@timeclock_clock_period)
    assert_response :success
  end

  test "should update timeclock_clock_period" do
    patch timeclock_clock_period_url(@timeclock_clock_period), params: { timeclock_clock_period: {  } }
    assert_redirected_to timeclock_clock_period_url(@timeclock_clock_period)
  end

  test "should destroy timeclock_clock_period" do
    assert_difference('Timeclock::ClockPeriod.count', -1) do
      delete timeclock_clock_period_url(@timeclock_clock_period)
    end

    assert_redirected_to timeclock_clock_periods_url
  end
end

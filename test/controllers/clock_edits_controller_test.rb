require 'test_helper'

class ClockEditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clock_edit = clock_edits(:one)
  end

  test "should get index" do
    get clock_edits_url
    assert_response :success
  end

  test "should get new" do
    get new_clock_edit_url
    assert_response :success
  end

  test "should create clock_edit" do
    assert_difference('ClockEdit.count') do
      post clock_edits_url, params: { clock_edit: { clock_record_id: @clock_edit.clock_record_id, deleted_at: @clock_edit.deleted_at, ip_address: @clock_edit.ip_address, note: @clock_edit.note, reason_id: @clock_edit.reason_id, user_id: @clock_edit.user_id } }
    end

    assert_redirected_to clock_edit_url(ClockEdit.last)
  end

  test "should show clock_edit" do
    get clock_edit_url(@clock_edit)
    assert_response :success
  end

  test "should get edit" do
    get edit_clock_edit_url(@clock_edit)
    assert_response :success
  end

  test "should update clock_edit" do
    patch clock_edit_url(@clock_edit), params: { clock_edit: { clock_record_id: @clock_edit.clock_record_id, deleted_at: @clock_edit.deleted_at, ip_address: @clock_edit.ip_address, note: @clock_edit.note, reason_id: @clock_edit.reason_id, user_id: @clock_edit.user_id } }
    assert_redirected_to clock_edit_url(@clock_edit)
  end

  test "should destroy clock_edit" do
    assert_difference('ClockEdit.count', -1) do
      delete clock_edit_url(@clock_edit)
    end

    assert_redirected_to clock_edits_url
  end
end

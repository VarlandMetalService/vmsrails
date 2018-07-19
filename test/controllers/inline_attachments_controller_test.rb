require 'test_helper'

class InlineAttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inline_attachment = inline_attachments(:one)
  end

  test "should get index" do
    get inline_attachments_url
    assert_response :success
  end

  test "should get new" do
    get new_inline_attachment_url
    assert_response :success
  end

  test "should create inline_attachment" do
    assert_difference('InlineAttachment.count') do
      post inline_attachments_url, params: { inline_attachment: { file: @inline_attachment.file } }
    end

    assert_redirected_to inline_attachment_url(InlineAttachment.last)
  end

  test "should show inline_attachment" do
    get inline_attachment_url(@inline_attachment)
    assert_response :success
  end

  test "should get edit" do
    get edit_inline_attachment_url(@inline_attachment)
    assert_response :success
  end

  test "should update inline_attachment" do
    patch inline_attachment_url(@inline_attachment), params: { inline_attachment: { file: @inline_attachment.file } }
    assert_redirected_to inline_attachment_url(@inline_attachment)
  end

  test "should destroy inline_attachment" do
    assert_difference('InlineAttachment.count', -1) do
      delete inline_attachment_url(@inline_attachment)
    end

    assert_redirected_to inline_attachments_url
  end
end

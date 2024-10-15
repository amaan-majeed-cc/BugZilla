require "test_helper"

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ticket_index_url
    assert_response :success
  end

  test "should get new" do
    get ticket_new_url
    assert_response :success
  end

  test "should get show" do
    get ticket_show_url
    assert_response :success
  end

  test "should get create" do
    get ticket_create_url
    assert_response :success
  end

  test "should get edit" do
    get ticket_edit_url
    assert_response :success
  end

  test "should get update" do
    get ticket_update_url
    assert_response :success
  end

  test "should get destroy" do
    get ticket_destroy_url
    assert_response :success
  end
end

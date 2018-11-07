require 'test_helper'

class Futadmin::DocControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get futadmin_doc_new_url
    assert_response :success
  end

  test "should get create" do
    get futadmin_doc_create_url
    assert_response :success
  end

  test "should get show" do
    get futadmin_doc_show_url
    assert_response :success
  end

end

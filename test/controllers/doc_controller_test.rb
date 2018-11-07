require 'test_helper'

class DocControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doc_index_url
    assert_response :success
  end

  test "should get download" do
    get doc_download_url
    assert_response :success
  end

  test "should get create" do
    get doc_create_url
    assert_response :success
  end

  test "should get delete" do
    get doc_delete_url
    assert_response :success
  end

end

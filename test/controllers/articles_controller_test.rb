require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get articles_create_url
    assert_response :success
  end

  test "should build correct url given source and query" do
    source = "Encyclopedia.com"
    query = "Roman Empire"
    expected_url = "https://www.encyclopedia.com/gsearch?q=roman+empire"
    built_url = build_url(source, query)
    assert built_url == expected_url
  end
end

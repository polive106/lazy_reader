require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article creation requires url" do
    assert Article.create(url: nil).valid? == false
  end

  test "should not save article without url" do
    article = Article.new
    assert_not article.save
  end
end

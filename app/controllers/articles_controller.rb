class ArticlesController < ApplicationController

    skip_before_action :authenticate_user!, only: [ :create ]

  def create
    args = get_article_info("wikipedia.com", params[:article][:query])
    article = Article.new(args)
    article.save
  end

  private

  # Build article url based on selected source and input query
  def get_article_info(source, query)
    parsed_query = query.split(' ').map { |word| URI.escape(word) }.join('+')
    if source == "wikipedia.com"
      search_url = "https://en.wikipedia.org/w/api.php?action=opensearch&search=#{parsed_query}"
      article_info = get_top_article_wikipedia(search_url)
    end
    return article_info
  end

  # On wikipedia.com, retrieve top search result url
  def get_top_article_wikipedia(url)
    response = JSON.parse(RestClient.get(url))
    articles = response[1]
    urls = response[3]
    top_article = {title: articles.first, url: urls.first }
  end
end

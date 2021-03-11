class ArticlesController < ApplicationController

    skip_before_action :authenticate_user!, only: [ :create, :find_sources ]

  def create
    @article = Article.new(params[:article])
    @article.save
    redirect_to article_path(@article)
  end

  # ask each supported source and collect articles
  def find_sources
    @articles_found = {}
    # Check wikipedia
    @articles_found[:wikipedia] = top_article_wikipedia(params[:article][:q])
    render 'pages/home'
  end

  private

  # On wikipedia.com, retrieve top search result url
  def top_article_wikipedia(query)
    parsed_query = query.split(' ').map { |word| URI.escape(word) }.join('+')
    url = "https://en.wikipedia.org/w/api.php?action=opensearch&search=#{parsed_query}"
    response = JSON.parse(RestClient.get(url))
    articles = response[1]
    urls = response[3]
    top_article = { title: articles.first, url: urls.first, source: "wikipedia.com" }
  end
end

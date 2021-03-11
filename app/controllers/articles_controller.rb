require 'open-uri'
require 'nokogiri'

class ArticlesController < ApplicationController

    skip_before_action :authenticate_user!, only: [ :create ]

  def create
    article = Article.new()
    article.url = article_url("wikipedia.com", params[:article][:query])
    article.save
  end

  private

  # Build article url based on selected source and input query
  def article_url(source, query)
    parsed_query = query.split(' ').map { |word| URI.escape(word) }.join('+')
    if source == "wikipedia.com"
      "https://en.wikipedia.org/w/index.php?search=#{parsed_query}&title=Special:Search&fulltext=1&ns0=1"
      search_url = "https://en.wikipedia.org/w/index.php?search=#{parsed_query}&title=Special:Search&fulltext=1&ns0=1"
      article_url = get_top_article_wikipedia(search_url)
    end
    return article_url
  end

  # On wikipedia.com, retrieve top search result url
  def get_top_article_wikipedia(url)

  end
end

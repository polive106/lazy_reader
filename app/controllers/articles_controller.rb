require 'open-uri'
require 'nokogiri'

class ArticlesController < ApplicationController

    skip_before_action :authenticate_user!, only: [ :create ]

  def create
    article = Article.new()
    article.url = article_url("encyclopedia.com", params[:article][:query])
    article.save
  end

  private

  # Build article url based on selected source and input query
  def article_url(source, query)
    parsed_query = query.split(' ').map { |word| URI.escape(word) }.join('+')
    if source == "encyclopedia.com"
      search_url = "https://www.encyclopedia.com/gsearch?q=#{parsed_query}"
      article_url = get_top_article_encyclopedia(search_url)
    end
    return article_url
  end

  # On encyclopedia.com, retrieve top search result url
  def get_top_article_encyclopedia(url)
    # TO DO - load page through headless chrome
    page = Nokogiri::HTML(open(url))
    top_link = page.css('a.gs-title').first
    return top_link['href']
  end
end

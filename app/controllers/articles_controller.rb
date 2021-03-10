require 'uri'

class ArticlesController < ApplicationController
  def create
  end

  private

  def build_url(source, query)
    parsed_query = query.split(' ').map { |word| URI.escape(word) }
    if source == "encyclopedia.com"
      url = "https://www.encyclopedia.com/gsearch?q=#{parsed_query}"
    end
  end
end

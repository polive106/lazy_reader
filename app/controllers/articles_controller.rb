class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :find_sources, :show ]

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to article_path(@article)
  end

  # ask each supported source and collect articles
  def find_sources
    @articles_found = {}
    @topic = params[:article][:q]
    # Check wikipedia
    @articles_found[:wikipedia] = top_article_wikipedia(params[:article][:q])
    render 'pages/home'
  end

  def show
    @article = Article.find(params[:id])
    if @article.content.nil?
      wiki_id = @article.url.split('/').pop()
      @article.content = scrap_article_content(@article)
      @article.save
    end
    respond_to do |format|
      format.html # will render a view by default
      format.json { render json: @article }
    end
  end

  private

  def scrap_article_content(article)
    html_file = RestClient.get(article.url)
    html_doc = Nokogiri::HTML(html_file)
    content = html_doc.search('p').reduce("") { |acc, elt| acc + elt.text.strip }
    article.content = content[0..5000]
  end

  # On wikipedia.com, retrieve top search result url
  def top_article_wikipedia(query)
    parsed_query = query.split.map { |word| URI.escape(word) }.join('+')
    url = "https://en.wikipedia.org/w/api.php?action=opensearch&search=#{parsed_query}"
    response = JSON.parse(RestClient.get(url))
    articles = response[1]
    urls = response[3]
    { title: articles.first, url: urls.first, source: "wikipedia.com" }
  end

  def article_params
    params.require(:article).permit(:source, :title, :url)
  end
end

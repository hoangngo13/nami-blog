class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update]

  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article created success!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def show
    
  end

  def edit
    
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated success!"
      redirect_to article_path(@article)
    else

    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
  
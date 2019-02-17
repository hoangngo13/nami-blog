class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = 1
    if @article.save
      flash[:sucess] = "Article created success!"
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
      flash[:sucess] = "Article updated success!"
      redirect_to article_path(@article)
    else

    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article deleted success!"
    redirect_to articles_path
  end
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
  
class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user
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

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "Could not edit another user's articles"
        redirect_to root_path
      end
    end
end
  
class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_article_comment, only: [:show, :edit, :update, :destroy,]

  def index
    @comments = @article.comments
  end

  def new
    @comment = @article.comments.build
  end
  
  def create
    @comment = @article.comments.create(comment_params)
    if @comment.save
      redirect_to article_comments_path(@article) 
      flash[:notice] = "Comment successfully created!"
    else
      flash[:alert] = "Please try again"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_comment_path(@article, @comment)
      flash[:notice] = "Comment successfully updated!"
    else
      flash[:alert] = "Failed updating comment, try again"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment successfully deleted!"
    redirect_to article_comments_path(@article)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  
  def set_article
    @article = Article.find(params[:article_id])
  end
  
  def set_article_comment
    @comment = @article.comments.find(params[:id])
  end
end

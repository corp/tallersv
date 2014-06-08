class CommentsController < ApplicationController
  before_action :set_article
  
  def index
  end
  
  def create
    @comment = @article.comments.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: 'Your comment was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { redirect_to @article, notice: 'Your comment was not created.'}
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  
  private
    def set_article
      @article = Article.find(params[:article_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:author, :body)
    end
end

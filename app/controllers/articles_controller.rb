class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :clean_multi_ids, only: [:create, :update]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
   
  # GET /articles
  # GET /articles.json
  def index
    per_page = 20
    
    if params[:user_id]
      @user=User.find_by_id(params[:user_id])
      redirect_to root_path, :notice=>"user not found" if @user.nil?
    elsif params[:slug]
      @category=Category.find_by_slug(params[:slug])
      redirect_to root_path, :notice=>"Category not found" if @category.nil?
    end
    
    last_updated = Article.order("updated_at DESC").limit(1).first
    
    @cache_key="articles_#{params[:user_id]}_#{params[:slug]}_#{params[:page]}_#{last_updated.updated_at.to_i}"
    @cache_view_key = "#{@cache_key}_view"
    
    if @user
      @articles = Rails.cache.fetch(@cache_key){
        @user.articles.order("created_at DESC").paginate(page: params[:page], per_page: per_page)
        }
      @list_title="Listing articles from #{@user.name}"
    elsif @category
      @articles = Rails.cache.fetch(@cache_key){
        @category.articles.order("created_at DESC").paginate(page: params[:page], per_page: per_page)
      }
      @list_title="Listing articles in #{@category.name}"
    else
      @articles = Rails.cache.fetch(@cache_key){
        Article.order("created_at DESC").paginate(page: params[:page], per_page: per_page)
      }
      @list_title="Listing all articles"
    end
    
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article.increment!(:views_count)
    @article.increment!(:daily_views)
    @comment=@article.comments.build
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def clean_multi_ids
      params[:article][:category_ids].delete_if{|e| e=="0"}
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :photo, :photo_cache, category_ids: [])
    end
end

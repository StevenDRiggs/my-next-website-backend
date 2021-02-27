class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :is_admin?, only: [:update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.as_json

    render json: @posts
  end

  # GET /posts/:slug OR GET /posts/:id
  def show
    render json: @post || {not_found: true}
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:slug OR PATCH/PUT /posts/:id
  def update
    if @post.update({
        title: post_params[:title],
        content: post_params[:content],
    })
      render json: Post.all.as_json
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:slug OR DELETE /posts/:id
  def destroy
    @post.destroy

    render json: Post.all.as_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_slug(params[:slug])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit([:title, :content, :slug])
    end
end

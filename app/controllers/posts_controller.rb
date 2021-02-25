class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

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
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:slug OR PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:slug OR DELETE /posts/:id
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_slug(params[:slug]).as_json
      if !@post
        @post = Post.find_by(id: post_params[:id]).as_json
      end
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit([:title, :content, :slug])
    end
end

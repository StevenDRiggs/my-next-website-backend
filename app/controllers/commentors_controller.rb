class CommentorsController < ApplicationController
  before_action :set_commentor, only: [:show, :update, :destroy]

  # GET /commentors
  def index
    @commentors = Commentor.all

    render json: @commentors
  end

  # GET /commentors/1
  def show
    render json: @commentor
  end

  # POST /commentors
  def create
    @commentor = Commentor.new(commentor_params)

    if @commentor.save
      render json: @commentor, status: :created, location: @commentor
    else
      render json: @commentor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /commentors/1
  def update
    if @commentor.update(commentor_params)
      render json: @commentor
    else
      render json: @commentor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commentors/1
  def destroy
    @commentor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentor
      @commentor = Commentor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def commentor_params
      params.require(:commentor).permit(:password, :password_confirmation, :liked_posts, :avatar_url)
    end
end

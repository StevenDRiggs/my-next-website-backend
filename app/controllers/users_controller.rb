class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorized, only: :auto_login

  #RESTful routes

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token({user_id: @user.id})
      session[:user_id] = @user.id
      render json: {
        user: {
          username: @user.username,
          email: @user.email,
          is_admin: @user.is_admin,
        },
        token: token
      }, status: :created, location: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end


  # non-RESTful routes
  def login
    username_or_email, password = user_params.values_at(:usernameOrEmail, :password)

    @user = User.find_by_username_or_email(username_or_email)
    unless @user && @user.authenticate(password)
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end

    token = encode_token({user_id: @user.id})
    session[:user_id] = @user.id

    render json: {
      user: {
        username: @user.username,
        email: @user.email,
        is_admin: @user.is_admin,
      },
      token: token
    }
  end

  def logout
    session.clear

    render json: 'Session cleared'
  end


  # processing methods

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit([:username, :email, :password, :usernameOrEmail])
  end
end

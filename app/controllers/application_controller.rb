class ApplicationController < ActionController::API
  #before_action :authorized, except: [:contact, :resume, :index, :show, :verify_login]


  # JWT methods
  @@secret_key = Rails.application.credentials.secret_key_base

  def encode_token(payload)
    JWT.encode(payload, @@secret_key)
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { Authorization: 'Bearer <token>' }
      begin
        JWT.decode(token, @@secret_key, true, algorithm: 'HS256')
      rescue JWT::DecodeError => error
        byebug
        render json: {error: error} and return
      end
    end
  end

#  def logged_in_user
#    if decoded_token
#      user_id = decoded_token[0]['user_id']
#      @user = User.find_by(id: user_id)
#    end
#  end
#
#  def logged_in?
#    !!logged_in_user
#  end
#
#  def authorized
#    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
#  end

#  def verify_login
#    if decoded_token && session[:user_id]
#      user = User.find_by(id: session[:user_id])
#
#      render json: {
#        verified: !!user && user.is_admin
#      }
#    end
#
#    render json: {
#      verified: false
#    }
#  end


  # mailer methods
  def contact
    name, email, message, response = params.values_at(:name, :email, :message, :response)

    ContactMailer.with(name: name, email: email, message: message, response: response).contact_me.deliver_now

    render json: {
      name: name,
      email: email,
      response: response
    }
    
  end

  def resume
    name, email = params.values_at(:name, :email)

    ResumeMailer.with(name: name, email: email).send_resume.deliver_now

    ResumeMailer.with(name: name, email: email).resume_requested.deliver_now

    render json: {
      name: name,
      email: email
    }
  end
end


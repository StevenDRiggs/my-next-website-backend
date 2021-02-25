class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
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
        JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
      rescue JWT::DecodeError => error
        render json: {errors: [error]} and return
      end
    end
  end

  def verify_login
    if decoded_token
      user_id = decoded_token[0]['user_id']
      if user_id == session[:user_id]
        @user = User.find_by(id: user_id)
      end
    end
  end

  def is_admin?
    verify_login

    render json: {errors: ['Must be logged in as admin']} unless @user && @user.is_admin
  end



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


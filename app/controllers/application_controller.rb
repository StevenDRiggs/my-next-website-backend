class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  before_action :set_csrf_cookie, only: [:new, :create, :edit, :update, :delete, :destroy, :login, :logout]

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


  private

  def set_csrf_cookie
    cookies['CSRF_TOKEN'] = form_authenticy_token
  end
end

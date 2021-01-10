class ApplicationController < ActionController::API
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

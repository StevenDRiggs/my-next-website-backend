class ApplicationController < ActionController::API
  def contact
    puts 'contact called'
    name, email, message, response = params.values_at(:name, :email, :message, :response)
    ContactMailer.with(name: name, email: email, message: message, response: response).contact_me.deliver_now

    render json: {
      name: name,
      email: email,
      response: response
    }
    
  end
end

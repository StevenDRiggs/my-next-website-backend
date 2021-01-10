class ResumeMailer < ApplicationMailer

  def send_resume
    @name, email = params.values_at(:name, :email)

    attachments['app/documents/Steven_Riggs_Resume.pdf'] = File.read("#{Dir.getwd}/app/documents/Steven_Riggs_Resume.pdf")

    mail(
      to: email,
      subject: "You requested Steven Riggs' resume"
    )
  end

  def resume_requested
    @name, @email = params.values_at(:name, :email)

    mail(
      to: ENV['EMAIL'],
      subject: "#{@name} requested your resume!"
    )
  end
end

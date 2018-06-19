class WelcomeMailer < ActionMailer::Base
  default from: "loler.at.gm@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome, dear!')
  end
end
class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.with(user: User.first).welcome
  end
end

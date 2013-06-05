class BooksMailer < ActionMailer::Base
  default from: "do-not-reply@aclbookclub.com"

  def review_notification(user, book)
  	@user = user
  	@book = book
  	mail(to: user.email, subject: "You've got new review on book!")
  end
end

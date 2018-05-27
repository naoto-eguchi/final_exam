class BlogMailer < ApplicationMailer
  def blog_mail(blog)
  @blog = blog

  mail to: "naotot725@gmail.com", subject: "ブログを作成しました！"
  end
end

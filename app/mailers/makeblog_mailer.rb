class MakeblogMailer < ApplicationMailer
  def makeblog_mail(blog)
    @blog = blog
    mail to: @blog.email, subject: "ブログ作成確認メール"
  end
end
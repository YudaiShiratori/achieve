class MakeblogMailer < ApplicationMailer
  def makeblog_mail(blog)
    @blog = blog
    mail to: "nyomyomo@usako.net", subject: "ブログ作成確認メール"
  end
end
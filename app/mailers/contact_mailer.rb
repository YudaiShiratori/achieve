class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "nyomyomo@usako.net", subject: "お問い合わせ確認メール"
  end
end
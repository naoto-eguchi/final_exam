class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    
    mail to: "自分メールアドレス", subject:"お問い合わせの確認メール"
  end
end

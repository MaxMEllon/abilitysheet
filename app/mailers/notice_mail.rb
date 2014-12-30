class NoticeMail < ActionMailer::Base
  default from: 'abilitysheet@iidxas.tk'

  def new_register(user_id)
    @user = User.find_by(id: user_id)
    @count = User.all.count

    mail to: 'sitan.chabots@gmail.com'
    mail subject: '新規登録者'
  end

  def new_message(message_id)
    @message = Message.find_by(id: message_id)
    mail to: 'sitan.chabots@gmail.com'
    mail subject: '新規問合せ'
  end
end
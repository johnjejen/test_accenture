class UserMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'

    def generate_mail_close_account(user_email,user_name,token_status)
	    @user_email  = user_email
      @user_name = user_name
      @token = token_status
     
      asunto = 'Closed Account'
	    mail(to: @user_email, subject: asunto.to_s)
    end

    def generate_mail_activate_account(user_email,user_name,token_status)
	    @user_email  = user_email
      @user_name = user_name
      @token = token_status
     
      asunto = 'Activate Account'
	    mail(to: @user_email, subject: asunto.to_s)
    end


  end
class UsersController < ApplicationController

   def index
   end

   def activate_account
    mail_status_account(2,params['uid'])
   end


   def close_account
    mail_status_account(1,params['uid'])
   end


   def close_account_do
    status_account(1,params['token'])
    current_user = request.headers["client"]
   end

   def activate_account_do
    status_account(2,params['token'])
   end
   
    def search_users
        render json: User.where("match(first_name, last_name, email) against (?)", params[:search])
    end
    
    private

    def mail_status_account(type_email,uid)
        user = User.where("uid=?", uid).take
        user_name = "#{user.first_name} #{user.last_name}".upcase
        random_string = ('0'..'9').to_a.shuffle.first(6).join
        token = Digest::MD5.hexdigest(random_string)
        user.token_status = token
        user.save
        if type_email == 1
            UserMailer.generate_mail_close_account(user.email,user_name,user.token_status).deliver
        else
            UserMailer.generate_mail_activate_account(user.email,user_name,user.token_status).deliver
        end
        render json: "Email was send"
    end

    def status_account(type_status,token)
        user_account = User.where('token_status=?',token).take
        if !user_account.blank?
            user_account.status_account_id = 1 if type_status == 1
            user_account.status_account_id = 2 if type_status == 2
            user_account.save
            render :json => { :error => false, msg: 'This account has been process successfully'}
        else
            render :json => { :error => false, msg: 'Account not found'}
        end
    end

end

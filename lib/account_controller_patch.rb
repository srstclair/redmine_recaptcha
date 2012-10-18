module AccountControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :register, :recaptcha_verification
    end
  end
  
  module InstanceMethods
    def register_with_recaptcha_verification
      redirect_to(home_url) && return unless Setting.self_registration? || session[:auth_source_registration]

      if request.get?
        session[:auth_source_registration] = nil
        @user = User.new(:language => Setting.default_language)
      else
        @user = User.new(params[:user])
        @user.admin = false
        @user.register
        if session[:auth_source_registration]
          @user.activate
          @user.login = session[:auth_source_registration][:login]
          @user.auth_source_id = session[:auth_source_registration][:auth_source_id]
          if @user.save
            session[:auth_source_registration] = nil
            self.logged_user = @user
            flash[:notice] = l(:notice_account_activated)
            redirect_to :controller => 'my', :action => 'account'
          end
        else
          @user.login = params[:user][:login]
          @user.password, @user.password_confirmation = params[:password], params[:password_confirmation]
          if verify_recaptcha( :private_key => Setting.plugin_redmine_recaptcha['recaptcha_private_key'], :model => @user, :message => "There was an error with the recaptcha code below. Please re-enter the code and click submit." )
            case Setting.self_registration
            when '1'
              register_by_email_activation(@user)
            when '3'
              register_automatically(@user)
            else
              register_manually_by_administrator(@user)
            end
          end
        end

        #the old method is accessible here:
        #register_without_recaptcha_verification
      end
    end
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
    def error(msg)
        render :text=>"{\"error\":\"#{msg}\"}"
    end
    def success(msg)
        render :text=>"{\"OK\":\"#{msg}\"}"
    end
    
    def check_session
       # p "===>session=#{session}"
       p "cookies[:_wh_session] = #{cookies[:_wh_session] }"
        # 
        # after uesr first register, the _wh_session will be set in user's cookie
        # which will send by all afteraward quest
        #
        if (params[:sid])
       #     reset_session
       
     #  p request.host
   #    p "====>>>>dda29"
       # set cookie first, because this is used to generate sid when write memcached
           cookies[:_wh_session] = {
               :value => params[:sid],
               :expires => 1.year.from_now,
               :domain => request.host
           }
        #   p "====>>>>dda69"+params[:sid]
       #    p "====>>>>dda79"+session[:sid]
            session[:sid] = params[:sid]
           # cookies[:_wh_session] = params[:sid]
        #   p "====>>>>dda39"
        else
        #    p "====>>>>dda19"
            if !session[:sid]
                sid = cookies[:_wh_session]
                if sid ==nil
                    sid = params[:sid] # for dev
                    if !sid
                        error("session not exist, please reinstall app or login again")
                        return false
                    end
                end  
                session[:sid] = sid
            end
        end
       # p "====>>>>dda9"
        if !session[:uid]
             r = User.find_by_sql("select * from users where sid='#{session[:sid]}'")
             player = r[0]
             session[:uid] = player[:id]
        end
        
        return true
    end
    
    def update_session_data(data)
        session[:userdata] = data
    end

    def user_data
        p "===>session[:userdata]=#{session[:userdata]}"
        if session[:userdata]
            return session[:userdata]
        else
            if (!session[:uid])
                if !check_session
                    error("session not exist, please reinstall app or login again")
                    return nil
                end
            end
            user = User.find(session[:uid])
            userexts = Userext.find_by_sql("select * from userexts where uid=#{session[:uid]}")
            user[:userext] = userexts[0]
            session[:userdata] = user
            return user
        end
    end
end

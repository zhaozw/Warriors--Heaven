# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
# require "utility.rb"
# require "skills/skill.rb"
# require "skills/unarmed.rb"
# require "skills/daofa.rb"
# require "skills/parry.rb"
# require "skills/fencing.rb"
# require "skills/huyuezhan.rb"
# require "skills/jiuguishengzhuan.rb"
# require "skills/konglingjian.rb"
# require "skills/qishangquan.rb"
# require "skills/yidaoliu.rb"
# require "skills/dodge.rb"
# require "skills/liefengdaofa.rb"


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  @serverurl = "http://localhost"
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter  :preload_models 
    def preload_models()  
        # p "#{File.dirname(__FILE__)}/lib/**/*.rb"
        Dir["#{File.dirname(__FILE__)}/../../lib/**/*.rb"].each { |f| 
            load(f)
            # p "load #{f}"
         }
         Userext
         Usereq
         Userskill
         Userquest
         Userrsch
         Battle
         Equipment
         Skill
         Team
         Tradable
         Game::Skill
         Skill
         Unarmed
         Dodge
         Parry
         Daofa
         Fencing
         Huyuezhan
         Jiuguishengzhuan
         Konglingjian
         Qishangquan
         Yidaoliu
         Liefengdaofa
         Ring
         Blade
    end
      
    def error(msg, data=nil)
         ret = {
            "error"=>msg
        }
        ret = ret.merge(data) if data
        render :text=>ret.to_json
        # render :text=>"{\"error\":\"#{msg}\"}"
    end
    def success(msg, data=nil)
        ret = {
            "OK"=>msg
        }
        ret = ret.merge(data) if data
        render :text=>ret.to_json
        
    end
    def device
         cookies[:d]
    end
    
    def check_session
       p "===>session id=#{session[:sid]} session uid = #{session[:uid]}"
       p "cookies[:_wh_session] = #{cookies[:_wh_session] }"
       
       if cookies[:_wh_session] 
            session[:uid] = nil if session[:sid] !=  session[:sid]
            session[:sid] = cookies[:_wh_session]       
        end
        # 
        # after uesr first register, the _wh_session will be set in user's cookie
        # which will send by all afteraward quest
        #
        if (params[:sid])
       #     reset_session
       
     #  p request.host
   #    p "====>>>>dda29"
       # set cookie first, because this is used to generate sid when write memcached
           if cookies[:_wh_session] == nil or cookies[:_wh_session] != params[:sid] # first time, or manually change session to other session
               
               cookies[:_wh_session] = {
                   :value => params[:sid],
                   :expires => 1.year.from_now,
                   :domain => request.host
               }
               session[:uid] = nil
           end
        #   p "====>>>>dda69"+params[:sid]
       #    p "====>>>>dda79"+session[:sid]
            if (session[:sid] == nil || params[:sid] != session[:sid] )
                session[:sid] = params[:sid]
                session[:uid] = nil
             end
             
            # @sid = params[:sid]

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
                session[:uid] = nil
            end
        end
       # p "====>>>>dda9"
        if !session[:uid]
             r = User.find_by_sql("select * from users where sid='#{session[:sid]}'")
             if !r or r.size == 0
                error("session not exist, please reinstall app or login again")
                return false
            end
             @userdata = r[0]
             session[:uid] = @userdata[:id]
        end
        
        return true
    end
    
  #  def update_session_data(data)
  #      session[:userdata] = data
  #  end

    def user_data
=begin
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
=end

        return nil if !check_session
        return @userdata if @userdata
        if !@userdata
            @userdata = User.get(session[:uid])
            p "===>@userdata=#{@userdata}"
            return @userdata
        end
        if !@userdata
            error("user not exist")
            return nil
        end
        return @userdata
    end

    def player
        if !@player
            @player = Player.new
            @player.set_data(user_data)
        end
        return @player
            
    end
=begin    
    def get_user(sid)
        r = $memcached.get(sid)
        if r && r[:userdata]
            return r[:userdata]
        else
            r1 = User.find_by_sql("select * from users where sid='#{session[:sid]}'")
            if (!r1 or r1.size==0)
                return nil
            else
                return r1[0]
            end
        end
    end

    def set_user(sid, data)
    end
=end    
end

class WhController < ApplicationController
    
    def index
        p "cookie=#{cookies}"
        session[:name]="ju"
        ret = {
            "uid" => "ju"
        }
        r = User.find_by_sql("select user, uid, sid, sex, race, age from users where sid='#{cookies[:_wh_session]}'")
   #     r = User.find_by_sql("select user, uid, sid, sex, race, age from users where sid='d434740f4ff4a5e758d4f340d7a5f467'")
        
        js = '{"error":"user not found"}'
        p r
        if (r.size >0)
            js = r[0].to_json
        end
        render :text=>js
    end
    
    def error(msg)
        render :text=>"{\"error\":#{msg}}"
    end
    def userext
        sid = cookies[:_wh_session]
        if !sid
            error("session not exist")
            return
        end
        
        r = Userext.find_by_sql("select uid, hp, maxhp, gold, exp, level, prop, sid from userexts where sid='#{sid}'")
         if (r.size >0)
            js = r[0].to_json
        else
            error("user not found")
            return
        end
        render :text=>js
    end
end

require 'rubyutility.rb'
class TeamController < ApplicationController
    def index
        
        return unless check_session and user_data
        
        # if (user_data[:team])
        #     render :text=>user_data[:team].to_json
        #     return
        # end
         prop = user_data.ext["prop"]
        
        if  prop.class == String
            prop = JSON.parse(prop)
        end
        p "prop=#{prop}"
        
        teamnotcreated = prop["teamnotcreated"]
        if teamnotcreated # create team
            p "==>create team"
            t = Team.new({
                :owner  => session[:uid],
                :code   => generate_password(6).upcase,
                :power  => 0,
                :prop   => "{}"     
            })
            t.save!
            prop.delete("teamnotcreated")
            user_data.ext[:prop] = prop.to_json
            user_data.ext.save!
            render :text=>t.to_json
       #     user_data[:team] 
            return
        end
        
        
=begin     
        list_myteam = {
            
        }
        list_joinedteam = []
        
        if prop[:myTeam]
            m = prop[:myTeam]
            for i in 0..7
                uid = m[i.to_s]
                if (uid)
                    u = User.find(uid)
                    list_myteam[i.to_s] = u
                end
            end
        end
=end       
       # if prop[:joinedTeam]
        #    m= prop[:joinedTeam]
            
        #end
        team = Team.find_by_sql("select * from teams where owner='#{session[:uid]}'")
        t = team[0]
        prop = JSON.parse(t[:prop])
        t[:members] = {}
        for i in 0..7
            if prop[i.to_s]
                u = User.find(prop[i.to_s].to_i)
                u.ext
                t[:members][i.to_s] = u
            end
        end
  #      ret = {
     #       :team=>list_myteam,
          #  :joinedTeam=>[
        #        ]
#        }
    #    user_data[:team] = ret
        render :text=>team[0].to_json
        return
    
    end
    

    def join
        return unless check_session and user_data
        code = params[:code]
        team = Team.find_by_sql("select * from teams where code='#{code}'")
        if (!team or  team.size==0)
            error("team not found")
            return
        end 
        if (team[0][:owner] == session[:uid])
            error("你已经在自己的战队中了")
            return
        end
        
        p team[0].inspect
        prop = JSON.parse(team[0][:prop])
      
     
        vac = -1
        for i in 0..7 
            
            if !prop[i.to_s]
               # prop[i] = session[:uid]
               p prop[i.to_s]
               vac = i
         
            elsif prop[i.to_s] == session[:uid]
                error("你已经是该战队的成员啦")
                return
            end
        end
        
        
        if  vac==-1
            error ("对不起， 该战队已满，请寻找其他战队加入")
            return
        end
        
        prop[vac.to_s] = session[:uid]
        team[0][:prop] = prop.to_json
        team[0].save!
        success("恭喜!您已成功加入该战队")
        return
 
    end
end

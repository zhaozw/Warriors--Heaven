require "utility.rb"

class QuestController < ApplicationController
    def self.list
        [
            "caiyao",   #采药任务
            "wudujiao",  #无毒教任务
            "yaowanggu",
            "yunbiao",
            # "xiakedao", # 侠客岛任务
            "hunt"
        ]
    end
    def index
        check_session
        unasked = []
        asked =[]
        list = QuestController.list
        # userquests = Userquest.find_by_sql("select * from userquests where uid=#{session[:uid]}")
        userquests = user_data.query_all_quests
        i =0 
        for q in list
            p q.inspect
            quest = load_quest(q)
            row = {
               "name"=> q,
               "dname"=> quest.dname,
               "desc"=> quest.desc,
               "image"=> quest.logo
           }
           # userquest = player.query_quest(q)
           # if userquest != nil
           p "===>userquests=#{userquests.keys}, q=#{q}, #{userquests.keys.include?q}"
           if userquests.keys.include?q.to_sym
               row[:progress] = userquests[q.to_sym][:progress]
               asked.push(row)
           else
               unasked.push(row)
           end
           
           
        end
        ret={
            "asked"=>asked,
            "unasked"=>unasked
        }
        
        render :text=> ret.to_json
        user_data.check_save
    end
    
    
    def ask
        check_session
        quest_name = params[:name]
        r = Userquest.find_by_sql("select * from userquests where uid=#{session[:uid]} and name='#{quest_name}'")
        if r and r.size >0
            error ("你已经领取过该任务了")
            return
        end
        quest = load_quest(quest_name)
        context = {
            :user=>player,
            :msg=>""
        }
        if !quest.onAsk(context)
            error(context[:msg])
            return
        end
        r = Userquest.new({
            :uid =>session[:uid],
            :sid =>session[:sid],
            :name=>quest_name,
            :progress=>0
        })
        r.save!
       # render :text=>"您成功领取任务"
       index
    end
    
    
    def show
        return if !check_session or !user_data
        @sid = params[:sid]
        @quest_name = params[:name]
        @quest = load_quest(@quest_name)
        @quest.setPlayer(player)
        data = player.query_quest(@quest_name)
        if (data==nil)
            render :text=>"任务不存在"
            return
        end
        @quest.setData(data)
        p"==>quest=#{@quest.inspect}"
        if !@quest
            error("load quest failed")
            return
        end
        # rs = Userquest.find_by_sql("select * from userquests where name='#{@quest_name}' and uid=#{user_data.id}")
         # @userquest = rs[0] if rs && rs.size>0
   
         # p "#{@userquest.inspect}"
        room = @quest.room
        
        if @quest.room && (@quest.room.end_with?(".rb") or @quest.room.end_with?(".erb") )
            render :template=>"quest/#{room}"
        end 
        
         p "==>ret=#{@quest.action_list.inspect}"
    
        user_data.check_save
    end
    
    def doAction
        return if !check_session or !user_data
        player.recover
        sid = params[:sid]
        quest_name  = params[:quest]
        #action_name = params[:action]
        @q = load_quest(quest_name)
        @q.setPlayer(player)
        @q.setData(player.query_quest(quest_name))
        if !@q
            error("load quest failed")
            return
        end
  #      @user = User.find_by_sql("select * from  users where sid='#{sid}'")
        @user = user_data
        @user.ext

        # player = Player.new
        #  player.set_data(@user)
        player.recover

        
        @action_context = {:action=>params[:action1], :user=>player, :msg=>""}
        @q.onAction(@action_context)
        user_data.check_save
        p @action_context.inspect
        ret = {
            :msg=>@action_context[:msg],
            :progress=>@user.query_quest(quest_name)[:progress],
            :room=>@action_context[:room],
            :actions=>@q.action_list
        }
        if @action_context[:script]
            ret[:script] = @action_context[:script]
        end
       
        render :text=>ret.to_json
    end
    
    def load_quest(name)
        if (!name or name == '')
            return nil
        end
        
        r = loadGameObject("quests/#{name}")
        return r
    end
end

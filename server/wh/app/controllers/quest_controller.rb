require "utility.rb"

class QuestController < ApplicationController
    def index
        check_session
        unasked = []
        asked =[]
        list = [
            "caiyao",   #采药任务
            "wudujiao"  #无毒教任务
            ]
        userquests = Userquest.find_by_sql("select * from userquests where uid=#{session[:uid]}")
        
        i =0 
        for q in list
            quest = load_quest(q)
            row = {
               "name"=> q,
               "dname"=> quest.dname,
               "desc"=> quest.desc
           }
            bfound = false
            for uq in userquests
                if q == uq[:name]
                    asked.push(row)
                    bfound = true
                    break
                end
            end
            if bfound
                next
            else
                unasked.push(row)
            end
           
        end
        ret={
            "asked"=>asked,
            "unasked"=>unasked
        }
        
        render :text=> ret.to_json
    end
    
    
    def ask
        check_session
        quest_name = params[:name]
        r = Userquest.find_by_sql("select * from userquests where uid=#{session[:uid]} and name='#{quest_name}'")
        if r and r.size >0
            error ("你已经领取过该任务了")
            return
        end
        r = Userquest.new({
            :uid =>session[:uid],
            :sid =>session[:sid],
            :name=>quest_name,
            :progress=>0
        })
        r.save!
        render :text=>"您成功领取任务"
    end
    
    
    def show
        @sid = params[:sid]
        @quest_name = params[:name]
        @quest = load_quest(@quest_name)
        room = @quest.room
        if @quest.room.end_with?(".rb") or @quest.room.end_with?(".erb")
            render :template=>"quest/#{room}"
        end 
        
    
        
    end
    
    def doAction
        sid = params[:sid]
        quest_name  = params[:quest]
        #action_name = params[:action]
        @q = load_quest(quest_name)
        @user = User.find_by_sql("select * from  users where sid='#{sid}'")
        @user[0].ext
        @action_context = {:action=>params[:action1], :user=>@user[0]}
        @q.onAction(@action_context)
    end
    def load_quest(name)
        r = loadGameObject("quests/#{name}")
    end
end

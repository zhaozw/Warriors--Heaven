require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Poem < Quest 
    def dname
       "唐诗" 
    end
    
    def desc
       "武林中颇多秘籍古书，读书写字有益于钻研武学。历代江湖高手中也不乏文人骚客。" 
    end
    
    def type
    end
    
    def room
        "这是一间古香古色的书房，窗明几净，一尘不染，书架上琳琅满目，都是诗词古籍。一位庄重严肃的老者坐在太师椅上讲学，那就是当今大儒朱先生了。在他的两侧坐满了求学的学生。"
#一张古意盎然的书案放在朱先生的前面，案上摆着几本翻开了的线装"
    end
    
    def logo
       "/game/quests/tangshi.jpg?v=2" 
    end
    
    def action_list
        p "===>qdata=#{data.inspect}, #{data[:progress].inspect}"
        if (data && data[:progress]>=100)
            p "==>1"
            a=   [
                {
                :name=>"restart",
                :dname=>"改めて任務を受け取る"
            }
        ]
        return a
        # else
        #               p "==>2"
        #             a =             [
        #                 {
        #                     :name=>"answer",
        #                     :dname=>"回答"
        #                 }
        #             ]
        #             return a
        end
    end
    def room_welcome
        t = Time.now.tv_usec.to_i
       srand(Time.now.tv_usec.to_i)
       i  = rand(poem_list.size)
       question = poem_list[i]
        msg = "<div>朱熹问道：#{question}</div>
        <div>
        <input name='usercmd' id='usermsg#{t}' ></input>
        <button id='answer'  type='button' class='action_button' style=\"font-size:12pt;padding:0;\" onclick=\"doAction('answer', 'answer='+$('\#usermsg#{t}').attr('value'))\">回答</button>
        </div>"
        data.set_prop("question", i)
        # data.save!
        return msg
    end
    def poem_list
        [ # from expensive to cheap
            "【举头望明月】的下句是什么？",
            "【牧童遥指杏花村】的上句是什么？",
            "【天生我才必有用】的下句是什么？",
            "【衣带渐宽终不悔】的下句是什么？",
            "【润物细无声】的上句是什么？",
            "【飞出寻常百姓家】的上句是什么？",
            "【乱花渐欲迷人眼】的下句是什么？",
            "【欲穷千里目】的下句是什么？",
            "【今宵酒醒何处，杨柳案】下句是什么？",
            "【问君能有几多愁几】的下句是什么？",
            "【春花秋月何时了】的下句是什么？",
            "【花落知多少】的前一句是什么？",
            "【云想衣裳花想容】的下句是什么？",
            "【一支红杏出墙来】的上句是什么？",
            "【国破山河在】的下句是什么？",
            "【南朝四百八十寺】的下句是什么？",
            "【烽火连三月】的下句是什么？",
            "【离离原上草】的下句是什么？",
            "【朝发白帝财运间】的下句是什么？",
            "【谁家新燕啄春泥】的上句是什么？",
            "【愿君多采撷】的下句是什么？",
            "【大梦谁先觉】的下句是什么？",
            "【二月春风似剪刀】的上句是什么？",
            "【大漠孤烟直】的下句是什么？",
            "【最是一年春好处】的下句是什么？",
            "【竹外桃花三两枝】的下句是什么？",
            "【春风又到江南岸】的下句是什么？",
            "【大风起兮云飞扬】的下句是什么？"
        ]
    end
    def answer_list
        [
            "低头思故乡",
            "借问酒家何处有",
            "千金散尽还复来",
            "为伊消得人憔悴",
            "随风潜入夜",
            "旧时王谢堂前燕",
            "浅草才能没马蹄",
            "更上一层楼",
            "晓风残月",
            "恰似一江春水向东流",
            "往事知多少",
            "夜来风雨声",
            "春风拂槛露华浓",
            "春色满园关不住",
            "城春草木深",
            "多少楼台烟雨中",
            "家书抵万金",
            "一岁一枯荣",
            "千里江陵一日还",
            "几处早莺争暖树",
            "此物最相思",
            "平生我自知",
            "不知细叶谁裁出",
            "长河落日圆",
            "绝胜烟柳满皇都",
            "春江水暖鸭先知",
            "明月何时照我还",
            "威加海内兮归四方"
            
            
        ]
    end
    
    def onAsk(context)
        player = context[:user]
        wl = player.query_wearing("handleft")
        if !wl
            wr =  player.query_wearing("handright")
            if !wr
                context[:msg] = "你打算空手去打猎?"
                return false
            end
        end

        return true
    end
    def onAction(context)
        user = context[:user]
        action = context[:action]
        params = context[:params]
        msg=""
         player = user
         
        if action =="restart"
            set_progress(0)
          context[:room] = self.room
          return
        end
          
        if player.ext[:jingli] <0 
        
                context[:msg]="<div>你的精力力不够， 休息休息吧 !</div>"
         
            return
        end
  

          srand(Time.now.tv_usec.to_i)
        if (action=="answer")
            # question = params[]
            ans = params[:answer]
            p "==>data=#{data.inspect}"
               i =data.get_prop("question").to_i
            p "==>answer=#{ans}, should be #{answer_list[i]}， i=#{i}"
            p "==>answer list = #{answer_list.inspect}"
            msg += "<div>你回答道：#{ans}</div>"
            if answer_list[i] == ans
                msg += yes_msg[rand(yes_msg.size)] % player.ext[:title]
                skill = player.query_skill("literature")
                if !skill
                    player.set_skill("literature", 0, 0)
                else
                  
                    tp = rand(10)
                    lu = player.improve_userskill("literature", tp)
                    msg += "<div class='gain'>你的读书写字有所提高(+#{tp})</div>"
                    if lu
                        msg += "<div class='gain'>你读书写字的等级提高了!</div>"
                    end
                end
                msg += room_welcome
            else
                msg += no_msg[rand(no_msg.size)] % player.ext[:title]
            end
            # msg += "<div class='gain'>你的潜能增加了。</div>"
      
        else # action != "dig"
            msg = "???"
        end
        context[:msg] = msg
        p context.inspect
    end
    def no_msg
        [
            "<div>朱熹摇摇头说:朽木不可雕也。</div>",
            "<div>朱熹一皱眉：%s需要多多用功啊。</div>"
        ]
    end
    def yes_msg
        [
            "<div>朱熹微笑着点头：孺子可教也。</div>",
            "<div>朱熹满意的看着你：%s将来必成大学问家!</div>"
        ]
    end
 
        
    
end
require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Yaowanggu < Quest 
    def dname
       "薬キング谷" 
    end
    
    def desc
       "药王谷藏有各种医学秘籍，想要配制丹药的武林人士，无不来这里询问" 
    end
    
    def type
    end
    
    def room
        "你想要什么?"
    end
    
    def logo
       "/game/quests/yaowanggu.jpg" 
    end
    
    def action_list
        [
            {
                :name=>"liu",
                :dname=>"六味帝黄丸"
            },
            {
                :name=>"qixinhaitang",
                :dname=>"七心海棠"
            }
        ]
    end
    

    def onAction(context)
        user = context[:user]
        action = context[:action]
        msg = ""
        p "===>items:#{user.query_items.inspect}"
        srand(Time.now.tv_usec.to_i)
        if (action=="liu")
                  # add_progress(100)
            msg = ""
            dihuang     = user.query_item("objects/fixtures/dihuang") 
            shanyao     = user.query_item("objects/fixtures/shanyao") 
            zexie       = user.query_item("objects/fixtures/zexie")                        
            fuling      = user.query_item("objects/fixtures/fuling")                        
            shanzhuyu   = user.query_item("objects/fixtures/shanzhuyu")                        
            mudan       = user.query_item("objects/fixtures/mudan")                        
                                 
            if (dihuang    and
                 shanyao    and
                 zexie      and
                 fuling     and
                 shanzhuyu  and
                 mudan      
                )
                     msg += "<div class='row'>程灵素说：阁下请稍等，我现在就去炮制药丸.</div>"
                     msg += "<div class='row'>过不多久, 药童便出来，递上一颗黑黑的药丸.</div>"
                     
                     wan = create_fixure("objects/fixtures/liuweidihuangwan")
                     user.delete_obj(dihuang)
                     user.delete_obj(shanyao)
                     user.delete_obj(shanzhuyu)
                     user.delete_obj(zexie)
                     user.delete_obj(mudan)
                     user.delete_obj(fuling)
              
                     user.get_obj(wan)
                     msg += "<div class='row'>你得到一颗<span style='color:red'>六位帝黄丸</span>!</div>"
                     r = user.query_quest("yaowanggu")
                     if !r[:progress]
                         r[:pregress] =0
                     end
                     if(!r.get_prop("liu"))
                         r.set_prop("liu", 1)
                         add_progress(20)
                     end
                 else
                     msg += "<div class='row'>程灵素说：此方为熟地黄八钱，山萸肉、干山药各四钱，泽泻、牡丹皮、白茯苓各三钱, 可滋肾补肝. 阁下的药材似乎还差几味。</div>"
                 end
        elsif  # action = "qixin"
            r = user.query_quest("yaowanggu")
            s = r.get_prop("qixin")
            if(!s)
                s = 0
                 r.set_prop("qixin", 1)
             else
                 s = s.to_i
            end
            if s<3
                m = [
                    "<div class='row'>程灵素说:‘天下第一毒物’七心海棠？我这里没有，阁下还是去其他地方找吧.</div>",
                    "<div class='row'>石万嗔大吃一惊，叫道：“怎么啦？七心海棠，七心海棠？难道死丫头种成了七心海棠</div>",
                    "<div class='row'>石万嗔双手在空中乱抓乱扑，大叫：“七心海棠，七心海棠！”冲出庙去。只听他凄厉的叫声渐渐远去，静夜之中，虽然隔了良久，还听得他的叫声隐隐从旷野间传来，有如发狂的野兽呼叫一般：“七心海棠！七心海棠！”</div>"
                    ]
                msg += m[s]
                r.set_prop("qixin", s+1)
            end
        
        else #
            msg = "???"
        end
        context[:msg] = msg
        p context.inspect
    end
          def onAsk(context)

        return true
    end
    
end
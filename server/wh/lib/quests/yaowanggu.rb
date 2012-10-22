require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Yaowanggu < Quest 
    def dname
       "薬王谷" 
    end
    
    def desc
        "薬王谷に各種類の医学の貴重の本があるので、薬を作りたい人々は皆ここに問い合わせに来る。"
    end
    
    def type
    end
    
    def room
        "あなたは何がほしいのか?"
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
                     msg += "<div class='row'>「閣下、ちょっと待ってください。これから丸薬を作ってくる。」と程霊素が言った。</div>"
                     msg += "<div class='row'>まもなく、アシスタントが出てきて、黒い丸薬を渡した。</div>"
                     
                     wan = create_fixure("objects/fixtures/liuweidihuangwan")
                     user.delete_obj(dihuang)
                     user.delete_obj(shanyao)
                     user.delete_obj(shanzhuyu)
                     user.delete_obj(zexie)
                     user.delete_obj(mudan)
                     user.delete_obj(fuling)
              
                     user.get_obj(wan)
                     msg += "<div class='row'>あなたが1錠<span style='color:red'>六味帝黄丸</span>を貰った!</div>"
                     r = user.query_quest("yaowanggu")
                     if !r[:progress]
                         r[:pregress] =0
                     end
                     if(!r.get_prop("liu"))
                         r.set_prop("liu", 1)
                         add_progress(20)
                     end
                 else
                     msg += "<div class='row'>「この処方は黄八銭と言い、山萸肉、干した山芋各20グラム、澤瀉、牡丹皮、白茯苓各15グラムより構成されている。腎臓や肝臓にいい。閣下の薬種はまだ何か足りないようだ。」と程霊素が言った。
</div>"
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
                    "<div class='row'>「天下第一毒物七心海棠なのか。ここにはないよ。閣下、他のところで探してみてください。」と程霊素が言った。</div>",
                    "<div class='row'>「天下第一毒物七心海棠なのか。ここにはないよ。閣下、他のところで探してみてください。」と程霊素が言った。</div>",
                    "<div class='row'>「天下第一毒物七心海棠なのか。ここにはないよ。閣下、他のところで探してみてください。」と程霊素が言った。</div>",
                    # "<div class='row'>石万嗔大吃一惊，叫道：“怎么啦？七心海棠，七心海棠？难道死丫头种成了七心海棠</div>",
                #    "<div class='row'>石万嗔双手在空中乱抓乱扑，大叫：“七心海棠，七心海棠！”冲出庙去。只听他凄厉的叫声渐渐远去，静夜之中，虽然隔了良久，还听得他的叫声隐隐从旷野间传来，有如发狂的野兽呼叫一般：“七心海棠！七心海棠！”</div>"
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
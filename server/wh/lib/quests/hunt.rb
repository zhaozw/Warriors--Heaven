require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Hunt < Quest 
    def dname
       "狩猟" 
    end
    
    def desc
       "听说附近山中常有野兽出没，更有人被老虎所伤，官府已贴出告示，招募义士为附近消除虎患。" 
    end
    
    def type
    end
    
    def room
        "这是座深山老林，千年高树遮住了阳光，树下都是丛生的灌木，需边走边劈断拦路的枝条。时而听到悉悉索索，似乎是野兔轻轻的跳过。"
    end
    
    def logo
       "/game/quests/hunt.jpg" 
    end
    
    def action_list
        p "===>qdata=#{data.inspect}, #{data[:progress].inspect}"
        if (data && data[:progress]>=100)
            p "==>1"
            a=   [
                {
                :name=>"restart",
                :dname=>"重新领取任务"
            }
        ]
        return a
        else
              p "==>2"
            a =             [
                {
                    :name=>"search",
                    :dname=>"寻找猎物"
                }
            ]
            return a
        end
    end
    
    def beast_list
        [ # from expensive to cheap
            "objects/npc/tiger",
            "objects/npc/snake",
            "objects/npc/yetu"
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
        msg=""
         player = user
         
        if action =="restart"
            set_progress(0)
          context[:room] = self.room
          return
        end
          if player.ext[:hp] <0 
     
               context[:msg]="<div>你的HP太低了, 先休息一下吧 !</div>"
     
            return
        end  
        if player.ext[:stam] <0 
        
                context[:msg]="<div>你的体力不够， 休息休息吧 !</div>"
         
            return
        end
  
        weapons = user.query_all_weapons
        p "=>weapons: #{weapons.values[0].inspect}"
        if weapons.size == 0
             context[:msg]="<div>你没有武器，无法打猎 !</div>"
            return 
        end
        p action
        srand(Time.now.tv_usec.to_i)
        
        if (action=="search")
            luck = user.ext[:luck]
            pp = rand(150)
            if (pp<luck) # get beast
        #  if (false)
         
                ar = beast_list
                if (luck < beast_list.size)
                    luck = beast_list.size
                end
                # r = caoyao_list[rand(100-luck)/(luck/caoyao_list.size)]
                # index =rand(ar.size)-rand(luck)*ar.size/100
                index = (rand(ar.size*2) + rand(ar.size*2))/2
                if index >= ar.size
                    index = ar.size - index%ar.size
                    index = ar.size-1 if index == ar.size
                end
                p "==>index #{index}"
                r = beast_list[index]
                npc = create_npc(r)
                    msg += "<div>忽然跳出一#{npc.unit}#{npc.name}，看样子要杀了你！</div>"
                npc.set_temp("level", user.ext[:level])
                player[:isUser] = true
                player[:canGain] = true
                _context = {:msg=>""}
                win = _fight(player, npc, _context)
                msg +=  _context[:msg].gsub(/<div class='st_lines'.*?<\/div>/i, "").gsub(/<div class=.status.>.*?<\/div>/mi, "")
                if (player[:gain][:exp] >0)
                    msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                end
                if (player[:gain][:level] > 0)
                    msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                end
           
                p "===>msg=#{msg}"
                if (win == 1)
                    # eqs = npc.query_all_equipments
                    #  eqs.each {|k,v|
                    #      user.get_obj(v)
                    #  }
                    drop = rand_drop(npc,player)
                    if drop
                        for dr in drop
                            if dr
                                msg += "\n<div class='gain' style='color:#990000'>你得到了一#{dr.unit}#{dr.dname}!</div>"
                            end
                        end
                    end
                    progress = 10
                    case index
                    when 0:progress=50
                    when 1:progress=30
                    when 2:progress=10
                    end
                    add_progress(progress)
    
            
                    if data[:progress] >= 100 && 
                        exp_bonus = 10+rand(user.tmp[:luck])/10
                        exp_bonus *=5
                        # levelup = user.add_exp(exp_bonus)
                        levelup = user.get_exp(exp_bonus)
                        msg += "<div><span style='color:#990000'>任务完成!</span><span>&nbsp;Exp +#{exp_bonus}</span></div>\n"
                        if (levelup)
                            msg+="<div><span style='color:#990000'>你的等级提升了!</div>"
                        end

                    end
                end
             
                
                # user.ext[:stam] -=5
                msg += "<div class='gain'>你的潜能增加了。</div>" if give_pot(player)
            else
     
                # if (pp > luck+80)
                    if false
                    msg = "<div>忽然跳出一个蒙面山贼，看样子要杀了你！</div>"
                    npc = create_npc("objects/npc/shanzei")
                    npc.set_temp("level", user.ext[:level])
         
                    _context = {:msg=>""}
                    player[:isUser] = true
                    player[:canGain] = true
                    win = _fight(player, npc, _context)
                    msg +=  _context[:msg].gsub(/<div class='st_lines'.*?<\/div>/i, "")
                    if (player[:gain][:exp] >0)
                        msg += "\n<div class='gain' style='color:#990000'>你的经验值增加了<span style='color:red'>#{player[:gain][:exp]}</span></div>"
                    end
                    if (player[:gain][:level] > 0)
                        msg += "\n<div class='gain' style='color:#990000'>你的等级提升了!</div>"
                    end
               
                    p "===>msg=#{msg}"
                    if (win == 1)
                        # eqs = npc.query_all_equipments
                        #  eqs.each {|k,v|
                        #      user.get_obj(v)
                        #  }
                        drop = drop_all(npc,player)
                        if drop
                            for dr in drop
                                msg += "\n<div class='gain' style='color:#990000'>你得到了一#{dr.unit}#{dr.dname}!</div>"
                            end
                        end
                        
                    end
                else
                    
                    msg = hunting_msg[rand(hunting_msg.size)] % weapons.values[0].dname
                    
                    user.ext[:stam] -=5
                    msg += "<div class='gain'>你的潜能增加了。</div>" if give_pot(player)
                end
            end
        else # action != "dig"
            msg = "???"
        end
        context[:msg] = msg
        p context.inspect
    end
    def hunting_msg
        [
            "<div>你不断挥动着%s劈砍灌木，向树林深处走去。</div>",
            "<div>你隐蔽在灌木中，耐心的等待猎物出现。</div>",
            "<div>太阳慢慢的西斜了，森林中的光线也越来越暗。你不断的寻找着地上动物经过的踪迹。</div>"
        ]
    end
    def give_pot(p1)
        if rand(100) < p1.tmp[:luck]
            p1.ext[:pot] += 1
            return true
        end
        return false
    end
        
    
end
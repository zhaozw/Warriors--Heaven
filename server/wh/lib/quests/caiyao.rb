require 'quests/quest.rb'
require 'fight.rb'
require 'objects/player.rb'

class Caiyao < Quest 
    def dname
       "采药" 
    end
    
    def desc
       "行走江湖，必须懂得如何采到必备的草药，以备不时只需." 
    end
    
    def type
    end
    
    def room
        "这是一片山中的树林，可能生长着各种草药.听说运气好的话，还能挖到人参等珍贵的药材。"
    end
    
    def logo
       "/game/quests/caiyao.png" 
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
                    :name=>"dig",
                    :dname=>"挖"
                }
            ]
            return a
        end
    end
    
    def caoyao_list
        [ # from expensive to cheap
            "objects/fixtures/ginseng",
            "objects/fixtures/heshouwu",
            "objects/fixtures/fuling",
            "objects/fixtures/dihuang",
            "objects/fixtures/shanzhuyu",
            "objects/fixtures/zexie",
            "objects/fixtures/shanyao",
            "objects/fixtures/mudan"
        ]
    end
    
    def onAsk(context)
        
        return true
    end
    def onAction(context)
        user = context[:user]
        action = context[:action]
        
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
  
  
        p action
        srand(Time.now.tv_usec.to_i)
        if (action=="dig")
            luck = user.ext[:luck]
            pp = rand(150)
            if (pp<luck) # get caiyao
         # if (false)
         # if true
                ar = caoyao_list
                if (luck < caoyao_list.size)
                    luck = caoyao_list.size
                end
                # r = caoyao_list[rand(100-luck)/(luck/caoyao_list.size)]
                # r = caoyao_list[rand(ar.size)-rand(luck)*ar.size/100]
                index = (rand(ar.size*2) + rand(ar.size*2))/2
                if index >= ar.size
                    index = ar.size - index%ar.size
                    index = ar.size() -1 if index == ar.size
                end
                r = caoyao_list[index]
                o = create_fixure(r)
                
                user.get_obj(o)
                msg = "<div><span style='color:#990000'>你挖到了一株<span style='color:red'>#{o.dname}</span></span> !</div>"
             
                skill = player.query_skill("caoyao")
                if !skill
                    p "===>create caoyao skill"
                    player.set_skill("caoyao", 0, 0)
                else
                  
                    tp = rand(10)
                    lu = player.improve_userskill("caoyao", tp)
                    msg += "<div class='gain'>你的草药学有所提高(+#{tp})</div>"
                    if lu
                        msg += "<div class='gain'>你草药学的等级提高了!</div>"
                    end
                end
             
             
                r = user.query_quest("caiyao")
                progress = 10
                if (r[:progress] < 100)
                    add_progress(progress)
               
                # r.save!
                
                    if r[:progress] >= 100 && 
                        exp_bonus = 10+rand(user.tmp[:luck])/10
                        # levelup = user.add_exp(exp_bonus)
                        levelup = user.get_exp(exp_bonus)
                        msg += "<div><span style='color:#990000'>任务完成!</span><span>&nbsp;经验+#{exp_bonus}</span></div>\n"
                        if (levelup>0)
                            msg+="<div><span style='color:#990000'>你的等级提升了!</div>"
                        end

                    end
                end
                user.ext[:stam] -=5
                msg += "<div class='gain'>你的潜能增加了。</div>" if give_pot(player)
            else
            #msg = "你很用力的挖"
     
                if (pp  > luck + 90)
                    ar = npc_list
                    index = (rand(ar.size*2) + rand(ar.size*2))/2
                    if index >= ar.size
                        index = ar.size - index%ar.size
                        index = rand(ar.size) if index == ar.size
                    end
                    npc_name = ar[index]
                    npc = create_npc(npc_name)
                    npc.set_temp("level", user.ext[:level])
                    msg = "<div>忽然跳出一#{npc.unit}#{npc.name}，看样子要杀了你！</div>"
                    
                   if npc_name == "objects/npc/shanzei"
                        full_skill_level = cacl_fullskill(user.ext[:level])
                        npc.set_skill("unarmed", full_skill_level, 0)
                        npc.set_skill("parry", full_skill_level, 0)
                        npc.set_skill("dodge", full_skill_level, 0)
                        npc.set_skill("daofa", full_skill_level, 0)
                   end
                     
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
                    
                    if (player[:gain][:skills])
                        player[:gain][:skills].each{|k,v|
                            if v[:point] > 0
                                msg +=  "\n<div class='gain' style='color:#990000'>你的#{v[:dname]}提升了#{v[:point]}点!</div>"
                            end
                        }
                    end
               
                    p "===>msg=#{msg}"
                    if (win == 1)
                        # eqs = npc.query_all_equipments
                        #  eqs.each {|k,v|
                        #      user.get_obj(v)
                        #  }    
                        drop = rand_drop(npc, player)
                        if drop
                            for dr in drop
                                msg += "\n<div class='gain' style='color:#990000'>你得到了一#{dr.unit}#{dr.dname}!</div>"
                            end
                        end
                        
                    end
                else
                    msg = "<div>你用药锄拨动着四周的灌木杂草，仔细地看有没有草药。</div>"
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
    
    def npc_list
        [ # from expensive to cheap
            # "objects/npc/tiger",
            # "objects/npc/snake",
            "objects/npc/shanzei",
            "objects/npc/yetu",
            "objects/npc/yetu"
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
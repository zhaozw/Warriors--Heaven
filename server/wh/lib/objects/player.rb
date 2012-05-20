require 'gamesettings.rb'
require 'objects/human.rb'

class Player < Human
    

    def initialize
        super
        @wearings={}
        @setup_wearing = false
    end
    
    # def initialize(userdata)
    #     # super(userdata)
    #     initialize
    #     set_data(userdata)
    # end
    
    def isPlayer
        true
    end
    
    def tmp
        if (!@obj[:userext]) 
            @obj.ext
        end
        if (@temp == nil)
            setup_temp
        end
         return @temp
    end
    
    def after_setdata
        setup_temp
        setup_wearing
    end
    

    def setup_wearing
        eqs = query_all_equipments
        eqs.each {|k,v|
        if (k.to_s[0] < 48 or k.to_s[0] > 57 ) and k.to_s[0] != 45  
            p k.to_s[0]
                p "==>wear #{v.inspect} on #{k.to_s}"  
            @wearings[k.to_sym] = v
        end
        }
         @setup_wearing = true
    end
=begin    
    def setup_wearing
        ext = @obj.ext
         prop =  ext[:prop]
        if (prop)
            j_prop = JSON.parse(prop)
            eqslot = j_prop["eqslot"]
            if eqslot
                 if eqslot.class == String
                    eqslot = JSON.parse(eqslot)
                     p "===>2.2#{eqslot}"
                 end
                 eqslot.each {|k,v|
                          if k[0] < 48 or k[0] > 57
                         r = Equipment.find(v)
                         if r 
                           eq = load_obj(r[:eqname], r)
                           if eq.obj_type == 'equipment'
                             wear(eq, k)
                            end
                         end
                     end
                     
                 }
            end
            
        end
    end
=end    
    def setup_temp
        p "setup_temp for #{@obj[:user]}"
        if (!@obj[:userext]) 
            @obj.ext
        end
        @temp = {
            :level =>@obj[:userext][:level  ],
            :jingli =>@obj[:userext][:jingli],
            :max_jl =>@obj[:userext][:max_jl],
              :exp   => @obj[:userext][:exp  ],
              :str   => @obj[:userext][:str  ],
              :hp    => @obj[:userext][:hp   ],
              :maxhp => @obj[:userext][:maxhp],
              :dext  => @obj[:userext][:dext ],
              :stam  => @obj[:userext][:stam ],
              :maxst => @obj[:userext][:maxst],
              :luck => @obj[:userext][:luck],
              :it  =>@obj[:userext][:it],
              :fame    =>@obj[:userext][:fame],
              :race    =>@obj[:userext][:race],
              :pot     =>@obj[:userext][:pot]
          }
          prop =  JSON.parse(@obj[:userext][:prop])
          prop.each {|k,v|
             @temp[k] = v   
         }
    end
    
    def ext
        @obj[:userext]
    end
    def setup_skill
        
    end
    def name
        @obj[:user]
    end
    
    def query_skill(name)
        @obj.query_skill(name)
    end
    def query_all_skills
        return @obj.query_all_skills
    end
    def set_temp(n, v)
        if !@temp
            setup_temp
        end
        @temp[n.to_sym] = v
    end
    def query_temp(name)
        # if (@obj[name])
        #     return @obj[name]
        # end
        # if (@obj.ext[name]) 
        #     return @obj.ext[name]
        # end
        # if !@temp
        #     setup_temp
        # end
        # return @temp[nam]
        return tmp[name.to_sym]
    end
    def query_wearing(position)
        if ! @setup_wearing 
            setup_wearing
        end
        @wearings[position.to_sym]
    end

    def query_equipment(position)
        # if !@worn_eq
        #     @worn_eq = {}
        #     eqslot = @obj.ext.get_prop("eqslot")
        #     p "===>eqslot=#{eqslot}"
        #     if eqslot
        #         if eqslot.class == String
        #             eqslot = JSON.parse(eqslot)
        #         end
        #         eqslot.each{|k,v|
        #             @worn_eq[k.to_sym] = v
        #         }
        #     end
        #              p "===>@worn_eq=#{@worn_eq}"
        # end
        # id = @worn_eq[position.to_sym]
        # if id
        #     eq = Equipment.find(id)
        # 
        #     return load_obj(eq[:eqname], eq)
        # end
        # 
        # return nil
        return @obj.query_equipment(position)
    end
    
    def id
        return data[:id]
    end
    
    def query_quest(quest)
        @obj.query_quest(quest)
    end
    
    def name
        @obj[:user]
    end
    
    def set_skill(n,l,tp)
       @obj.set_skill(n,l,tp) 
    end
    
    def get_obj(o)
        @obj.get_obj(o)
    end
    
    # def add_exp(add_exp)
    #     if ( (tmp[:level]+1)*(tmp[:level]+1)*(tmp[:level]+1)<= tmp[:exp]+add_exp)
    #         tmp[:level] += 1
    #         ext[:level] += 1
    #         tmp[:exp] = ext[:exp] = 0
    #         return true
    #     else
    #         return false
    #     end
    # end
    
    def get_exp(exp)
        return data.get_exp(exp)
    end
    
    def receive_gold(g)
        data.ext[:gold] += g
    end
    
    def query_quest(quest)
        @obj.query_quest(quest)
    end
    
    def hp
        diff = Time.now - ext[:updated_at]
        if ext[:hp] < ext[:maxhp]
            ext[:hp] += ext[:maxhp] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:hp] > ext[:maxhp])
                ext[:hp] = ext[:maxhp]
            end
        end
    end

    def stam
        diff = Time.now - ext[:updated_at]
        if ext[:stam] < ext[:maxst]
            ext[:stam] += ext[:maxst] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:stam] > ext[:maxst])
                ext[:stam] = ext[:maxst]
            end
        end
    end
    
    def jingli
        diff = Time.now - ext[:updated_at]
        if ext[:jingli] < ext[:max_jl]
            ext[:jingli] += ext[:max_jl] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:jingli] > ext[:max_jl])
                ext[:jingli] = ext[:max_jl]
            end
        end
    end
    

    def query_all_wearings
        if ! @setup_wearing 
            setup_wearing
        end
      @wearings
    end
    def query_all_equipments
        @obj.query_all_equipments
    end
    
    def recover

        diff = Time.now - ext[:updated_at]
    
        rate = 100 # recover 1/100 of max per second
        
        # hasMuren = ext.get_prop("hasMuren")
        #   if hasMuren && hasMuren > 0
        #       rate = rate /2
        #       ext.set_prop("hasMuren", hasMuren-1)
        #   end
        
        
        
        if ext[:hp] < ext[:maxhp]
            ext[:hp] += ext[:maxhp] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:hp] > ext[:maxhp])
                ext[:hp] = ext[:maxhp]
            end
        end
        
                
        if ext[:stam] < ext[:maxst]
            ext[:stam] += ext[:maxst] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:stam] > ext[:maxst])
                ext[:stam] = ext[:maxst]
            end
        end
        
                
        if ext[:jingli] < ext[:max_jl]
            ext[:jingli] += ext[:max_jl] * diff /200  # maxhp/20 * (diff/10)
            if (ext[:jingli] > ext[:max_jl])
                ext[:jingli] = ext[:max_jl]
            end
        end
        
        tmp[:hp] = ext[:hp]
        tmp[:stam] =ext[:stam]
        tmp[:jingli] = ext[:jingli]
        p "recover finish: hp:#{ ext[:hp]}, st:#{ext[:stam]}, jingli:#{ext[:jingli]}"
 
    end
    
    def practise(skill, sec)
        # skill = query_skill(skillname)
        skillname = skill[:skname]
        int = ext[:it]
        pot = ext[:pot]
        jingli = ext[:jingli]
          
        # try to use all pot
        # usepot = pot
        
        rate = 1 # consume 1 pot per second
        
        rate_add_fix = nil
        if (skillname == "unarmed")
            rate_fix = "shadai"
            rate_add_fix = ext.get_prop("shadai")
            if rate_add_fix && rate_add_fix > 0
                rate = rate *2
            end
        elsif (skillname == "parry")
            rate_fix = "muren"
            rate_add_fix = ext.get_prop("muren")
            rate = rate * 2 if rate_add_fix && rate_add_fix > 0
        elsif skillname == "dodge"
            rate_fix = "meihuazhuang"
            rate_add_fix = ext.get_prop("meihuazhuang")
            rate = rate * 2 if rate_add_fix && rate_add_fix >0
        end
        
        usepot= rate * sec
        usepot= pot if usepot > pot
        
        
        
        # max pot can be used is limited by exp
        max_pot = 0
        e = ext[:exp] + calc_total_exp(ext[:level])
        if (skill[:level] +1) * (skill[:level] +1) *(skill[:level] +1)/10>e
            max_pot = (skill[:level] +1) * (skill[:level] +1) - skill[:tp]
        end
        
        if max_pot < usepot
            usepot = max_pot
        end
        
        # more int, consume less jingli
        # for int = 20, 1 jingli for every pot
        cost_jingli = usepot*20/int
        
        levelup = improve_skill(self, skillname, max_pot)
        if levelup
            if rate_add_fix-usepot < 0
                fix_name = ""
                case rate_fix
                    when "muren": fix_name="objects/special/muren"
                    when "shadai": fix_name="objects/special/shadai"
                    when "meihuazhuang": fix_name="objects/special/meihuazhuang"
                end
                f =   query_obj(fix_name)
                f_hp = f.hp - usepot
                if f_hp >= 0
                    f.set_prop("hp", f_hp)
                else
                    delete_obj(f)
                end
                # f.save
            end
        end

        ext[:jingli] -= cost_jingli
        ext[:pot] -= usepot      
        # pending = {}
        #   
        #   ext.set_prop("pending", pending)
        if rate_add_fix && rate_add_fix >0
            ext.set_prop(rate_fix, rate_add_fix-usepot)
        end
        return usepot
    end
    # remove and delete record
    def delete_obj(obj)
        data.delete_obj(obj)
    end
    # remove associate between obj and player
    def remove_obj(obj)
        data.remove_obj(obj)
        unwear(obj)
    end
    def query_items
        data.query_items
    end
    def query_carrying
        data.query_items
    end
    def query_item(name)
        return data.query_item(name)
    end
    def query_obj_by_id(id)
        data.query_obj_by_id(id)
    end
    def query_obj(name)
        data.query_obj(name)
    end
    def query_team
        return data.query_team
    end

    
    def get_exp(exp)
         levelup = 0
         exp_next_level = (ext[:level]+1)**3
         if (exp_next_level<= ext[:exp]+exp)
             levelup = 1
             # check if defeated hero in legend
             levelHero = BossForLevelup(ext[:level]+levelup)
             pass = true
             hero = ""
             if levelHero
                 defeatHero = ext.get_prop("defeatHero")
                 levelHero.each {|h|
                     if !defeatHero.include?()
                         hero = h
                         pass = false
                         break
                     end
                }
             end 
             
             if !pass
                 send_msg(id, "你的等级无法提升，你需要打败#{hero}才能升至#{ext[:level]+levelup}级")
             else
                 ext[:level] += 1
                 ext[:exp] = 0
                 mh_bonus = rand(ext[:level]/2 )
                 mh_bonus = ext[:level]/3 if mh_bonus <= ext[:level]/3
                 ext[:maxhp] += mh_bonus
                 
                 mst_bonus = rand(ext[:level]/2 )
                 mst_bonus = ext[:level]/3 if mst_bonus <= ext[:level]/3
                 ext[:maxst] += mst_bonus
                 
                 mjl_bonus = rand(ext[:level]/2 )
                 mjl_bonus = ext[:level]/3 if mjl_bonus <= ext[:level]/3
                 ext[:max_jl] += mjl_bonus
             end  
             

         else
             ext[:exp] += exp
        end
        return levelup
     end
     
     def hp
         tmp[:hp]
     end
end
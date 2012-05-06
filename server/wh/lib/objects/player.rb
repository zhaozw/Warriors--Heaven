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
    
    def isUser
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
        if k.to_s[0] < 48 or k.to_s[0] > 57  
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
    
    def query_quest(quest)
        @obj.query_quest(quest)
    end
    
    def name
        @obj[:user]
    end
    
    def set_skill(n,l,tp)
       @obj.set_skill(n,l,tp) 
    end
    
    def get_object(o)
        @obj.get_object(o)
    end
    
    def add_exp(add_exp)
        if ( (tmp[:level]+1)*(tmp[:level]+1)*(tmp[:level]+1)<= tmp[:exp]+add_exp)
            tmp[:level] += 1
            ext[:level] += 1
            tmp[:exp] = ext[:exp] = 0
            return true
        else
            return false
        end
        
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
    
    def practise(skillname, usepot)
        skill = query_skill(skillname)
        int = ext[:it]
        pot = ext[:pot]
        jingli = ext[:jingli]
           
        # max pot can be used limited by exp
        max_pot = 0
        e = ext[:exp] + calc_total_exp(ext[:level])
        if (skill[:level] +1) * (skill[:level] +1) *(skill[:level] +1)/10>e
            max_pot = (skill[:level] +1) * (skill[:level] +1) - skill[:tp]
        end
        
        if max_pot < usepot
            usepot = max_pot
        end
        

        cost_jingli = usepot*20/int
        
        levelup = improve_skill(self, skillname, max_pot)
        ext[:jingli] -= cost_jingli
        ext[:pot] -= usepot      
        pending = {}
        
        ext.set_prop("pending", pending)

    end
end
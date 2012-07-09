require 'objects/object.rb'


class LivingObject < Game::Object
    @wearing={}
    @carrying =[] # carrying include wearing
     
    def initialize
        super
        @wearing={}
        @carrying =[]
    end
    
    def race
        "human"
    end
    
    def carry(o)
        @carrying.push(o)
    end
    
    def query_carrying
        return @carrying
    end
    
    def query_all_obj
        @wearing.values+@carrying
    end
    def remove_obj(o)
        if @carrying.include?(o)
            @carrying.delete(o)
        end
        
        unwear(o) if o.obj_type == "equipment"
    end
    
    def unwear(eq)
        @wearing.each{|k,v|
            if v.id == eq.id
                @wearing.delete(k)
            end
        }
    end
    def wear(pos, eq)
        return if !eq
        if !@wearing
            @wearing = {}
        end
        @wearing[pos.to_sym] = eq
    end
    def query_wearing(pos)
        if !@wearing
            @wearing = {}
        end
        return @wearing[pos.to_sym]
    end
    def query_all_wearings
        if !@wearing
            @wearing = {}
        end
        return @wearing
    end
    def query_all_weapons
        @weapons = {}
        weapon = query_wearing("handright")
        if weapon
            @weapons[:handright] = weapon
        end
        weapon = query_wearing("handleft")
        if weapon
            @weapons[:handleft] = weapon
        end
        return @weapons
    end
    
    # def query_weapon_damage
    #    d = 0 
    #    weapon = query_equipment("handright")
    #    if weapon 
    #        d += weapon.damage
    #    end
    #    weapon = query_equipment("handleft")
    #    if weapon 
    #        d += weapon.damage
    #    end
    #    return d
    # end
    # 
    # def query_armo_defense
    #    d = 0 
    #    armo = query_equipment("head")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("arm")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("body")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("neck")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("fingerleft")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("foot")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("leg")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    armo = query_equipment("fingerright")
    #    if armo 
    #        d += weapon.defense
    #    end
    #    return d
    # end
    
    def query_all_weight
       d = 0 
        eqs = query_all_wearings
        p "=>wearing=#{eqs.inspect}"
        eqs.each {|k,v|
            d+= v.weight if v
        }
       return d
    end
    def query_weapon_damage
        damage = 0
        all = query_all_wearings
        all.each {|k,v|   
            if v
                p "#{v.dname} damage #{v.damage}"                 
                damage += v.damage
            end
        }
        return damage
    end
    def query_armo_defense
        p "==>calc armo defense"
        defense = 0
        all = query_all_wearings
        all.each {|k,v|    
            if v
                p "v.dname defense #{v.defense}"              
                defense += v.defense
            end
        }
        return defense
    end
    # def query_weapons
    #     ret =[]
    #     a = query_wearing("handright")
    #     ret.push(a) if a
    #     a= query_wearing("handleft")
    #     ret.push(a) if a
    #     return ret
    # end
    def hasWeapon?
        return query_all_weapons.size > 0
    end
    
    
 
    def check_poison
         p = self
        r = p.get_poisoned
        return "" if !r
        
        if r.class == String
            r = JSON.parse(r)
        end
        am = r['amount'].to_i
        if am > 0
            # m = "<div class='poisoned'>"
            m = "<br/>\n<span class='poisoned'>"
            if (r['name'] == "蛇毒")
                m += "$N觉得伤口逐渐发麻,"
            elsif (r['name'] == "情花毒")
                m += "$N觉得被情花刺破之处一阵剧痛"
            end
            m += "#{r['name']}发作了！"

            p.tmp[:hp] -= am
        
            m+="(hp-#{am})</span><br/>"
            u = Time.now.to_i - r['time'].to_i
            p "==>check_poison: span time #{u}"
        
            if (u>10)
                _am = am - am*u/1000
                if _am >0
                    if _am != am
                        r['amount'] = am
                        r['time'] = Time.now.to_i
                        p.set_prop("poisoned",r)
                    end
                else
                    p.release_poisoned
                end
            end
        else
            p.release_poisoned
        end
            
        return m
    end
end
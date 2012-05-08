require 'objects/object.rb'


class LivingObject < Game::Object
    @wearing={}
     
    def initialize
        @wearing={}
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
        eqs.each {|k,v|
            d+= v.weight
        }
       return d
    end
    def query_weapon_damage
        damage = 0
        all = query_all_wearings
        all.each {|k,v|   
            p "#{v.dname} damage #{v.damage}"                 
            damage += v.damage
        }
        return damage
    end
    def query_armo_defense
        p "==>calc armo defense"
        defense = 0
        all = query_all_wearings
        all.each {|k,v|    
            p "v.dname defense #{v.defense}"              
         defense += v.defense
        }
        return defense
    end
end
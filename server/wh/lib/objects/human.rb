require 'objects/livingobject.rb'


class Human < LivingObject
    
    def limbs
    [
        "頭部", "首部", "みぞおち", "背中の真ん中", "左肩", "右肩", "左腕",
        "右腕", "左手", "右手", "腰", "下腹", "左足", "右足",
        "左足下", "右足下"
    ]
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
    # 
    # def query_all_weight
    #    d = 0 
    #     eqs = query_all_equipments
    #     eqs.each {|k,v|
    #         d+= v.weight
    #     }
    #    return d
    # end
    
end
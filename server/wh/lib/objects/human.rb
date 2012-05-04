require 'objects/livingobject.rb'


class Human < LivingObject
    
    def limbs
    [
        "头部", "颈部", "胸口", "后心", "左肩", "右肩", "左臂",
        "右臂", "左手", "右手", "腰间", "小腹", "左腿", "右腿",
        "左脚", "右脚"
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